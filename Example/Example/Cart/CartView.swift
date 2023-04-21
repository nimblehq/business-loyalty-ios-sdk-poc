//
//  CartView.swift
//  Example
//
//  Created by Edgars Simanovskis on 20/4/23.
//

import Kingfisher
import NimbleLoyalty
import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CartViewModel()

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    viewModel.loadCart()
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
                        ForEach(viewModel.cart?.orderLineItems ?? [], id: \.self) { lineItem in
                            NavigationLink(
                                destination: ProductDetailView(id: lineItem.productId ?? "")
                            ) {
                                CartItemView(item: lineItem, useAction: {
                                    print("cart item action")
                                })
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
                    Text("Cart")
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

struct CartItemView: View {

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    let item: APIOrderLineItem
    var useAction: () -> Void
    var body: some View {
        VStack(spacing: 16.0) {
            HStack(alignment: .center, spacing: 16.0) {
                KFImage(URL(string: item.product?.imageUrl ?? ""))
                    .onFailureImage(UIImage(named: "logo_square"))
                    .resizable()
                    .frame(width: 56.0, height: 56.0)
                    .cornerRadius(4.0)
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(item.product?.name ?? "")
                        .font(.system(size: 13.0))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Constants.Color.mirageBlack)
                        .lineLimit(2)
//                    Text("Until \(reward.reward?.expiresOn?.formatDate() ?? "")")
//                        .font(.system(size: 13.0))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .foregroundColor(Constants.Color.slateGray)
//                        .lineLimit(1)
                }
                Spacer(minLength: 0.0)
                Button(action: {
                    useAction()
                }) {
                    HStack {
                        Spacer()
                        Text("Use")
                            .font(.system(size: 14.0))
                            .fontWeight(.bold)
                            .foregroundColor(Constants.Color.havelockBlue)
                        Spacer()
                    }
                }
                .frame(width: 52.0, height: 32.0)
                .background(Color.white)
                .border(Constants.Color.catskillWhite, width: 1.0)
                .cornerRadius(4.0)
            }
            .padding(.horizontal, 15.0)
            Divider()
                .frame(height: 1.0)
                .background(Constants.Color.catskillWhite)
                .padding(.horizontal, 15.0)
        }
        .frame(height: 72.0)
    }
}
