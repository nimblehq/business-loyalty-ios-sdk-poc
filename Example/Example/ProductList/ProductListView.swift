//
//  ProductListView.swift
//  Example
//
//  Created by Edgars Simanovskis on 17/4/23.
//

import Kingfisher
import NimbleLoyalty
import SwiftUI

struct ProductListView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ProductListViewModel()

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    viewModel.loadProducts()
                }
        case .loaded:
            setUpView()
        case .loading:
            setUpView(isLoading: true)
        case let .error(message):
            setUpView()
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("Example"),
                        message: Text(message),
                        dismissButton: Alert.Button.default(Text("OK"))
                    )
                }
        }
    }
    
    private func setUpView(isLoading: Bool = false) -> some View {
        VStack {
            ScrollView {
                if isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Constants.Color.havelockBlue))
                            .frame(maxHeight: .infinity, alignment: .center)
                    }
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(viewModel.products, id: \.self) { product in
                            NavigationLink(
                                destination: ProductDetailView(
                                    id: product.id
                                )
                            ) {
                                ProductItemView(
                                    product: product,
                                    action: { code in
//                                        viewModel.redeemReward(code: code)
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Products")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Constants.Color.havelockBlue)
                        .frame(height: 24.0)
                        .padding(.vertical, 20.0)
                }
            }
        }
        .modifier(NavigationBackButtonModifier(action: {
            presentationMode.wrappedValue.dismiss()
        }))
    }
}

struct ProductItemView: View {

    let product: APIProduct

    var action: (String) -> Void

    var body: some View {
        VStack(spacing: 8.0) {
            KFImage(URL(string: product.imageUrl ?? ""))
                .onFailureImage(UIImage(named: "logo_square"))
                .resizable()
                .scaledToFill()
                .frame(height: 126.0)
                .padding(.top, 8.0)
                .clipped()
            VStack(spacing: 4.0) {
                Text(product.name ?? "")
                    .font(.system(size: 13.0))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Constants.Color.mirageBlack)
                    .lineLimit(1)
                Text(product.description ?? "")
                    .font(.system(size: 13.0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Constants.Color.slateGray)
                    .lineLimit(2)
            }
            .padding(.horizontal, 8.0)
            PrimaryButton(
                isEnabled: .constant(true),
                isLoading: false,
                action: {
                    action(product.id)
                },
                title: "View"
            )
            .padding(.bottom, 8.0)
        }
        .frame(height: 265.0)
        .border(Constants.Color.catskillWhite, width: 1.0)
        .cornerRadius(4.0)
        .background(Color.white)
    }
}

struct ProductListViewPreView: PreviewProvider {

    static var previews: some View {
        ProductListView()
    }
}
