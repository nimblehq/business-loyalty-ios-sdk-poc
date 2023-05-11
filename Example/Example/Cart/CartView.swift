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
    
    func deleteItems(at offsets: IndexSet) {
        viewModel.cart?.orderLineItems?.remove(atOffsets: offsets)
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
                    VStack(spacing: 8.0) {
                        Spacer()
                        ForEach(viewModel.cart?.orderLineItems ?? [], id: \.self) { lineItem in
                            CartItemView(item: lineItem, useAction: {
                                print("cart item action")
                            })
//                            .frame(minHeight: 90.0)
                        }
                        VStack(spacing: 8.0) {
                            HStack {
                                Text("Subtotal")
                                    .font(.system(size: 13.0))
                                Spacer()
                                Text("\(viewModel.cart?.subtotalPrice ?? "") SGD")
                                    .font(.system(size: 13.0))
                            }
                            HStack {
                                Text("Shipment cost")
                                    .font(.system(size: 13.0))
                                Spacer()
                                Text("\(viewModel.cart?.shipmentCost ?? "") SGD")
                                    .font(.system(size: 13.0))
                            }
                            HStack {
                                Text("Total")
                                    .font(.system(size: 14.0))
                                    .fontWeight(.bold)
                                    .foregroundColor(Constants.Color.mirageBlack)
                                Spacer()
                                Text("\(viewModel.cart?.finalPrice ?? "") SGD")
                                    .font(.system(size: 14.0))
                                    .fontWeight(.bold)
                                    .foregroundColor(Constants.Color.mirageBlack)
                            }
                        }
                        .padding(.horizontal, 15.0)
                    }
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
            HStack(alignment: .top, spacing: 16.0) {
                KFImage(URL(string: item.product?.imageUrl ?? ""))
                    .onFailureImage(UIImage(named: "logo_square"))
                    .resizable()
                    .frame(width: 72.0, height: 72.0)
                    .cornerRadius(4.0)
                VStack(alignment: .leading, spacing: 4.0) {
                    HStack(alignment: .center) {
                        Text("x\(item.quantity ?? 0)")
                            .font(.system(size: 12.0))
                            .foregroundColor(Constants.Color.slateGray)
                        Text(item.product?.name ?? "")
                            .font(.system(size: 14.0))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Constants.Color.mirageBlack)
                            .lineLimit(2)
                    }
                    Text("\(item.finalPrice ?? "") SGD")
                        .font(.system(size: 13.0))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Constants.Color.mirageBlack)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 15.0)
            Divider()
                .frame(height: 1.0)
                .background(Constants.Color.catskillWhite)
                .padding(.horizontal, 15.0)
        }
        .frame(height: 90.0)
    }
}

