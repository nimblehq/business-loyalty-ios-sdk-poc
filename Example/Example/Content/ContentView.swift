//
//  ContentView.swift
//  Example
//
//  Created by David Bui on 20/03/2023.
//

import NimbleLoyalty
import SwiftUI
import UIKit

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()
    @State var showRewardListView = false
    @State var showRewardHistoryView = false
    @State var showProductListView = false
    @State var showCartView = false
    
    
    init(forPreview: Bool = false) {
        guard forPreview else { return }
        let viewModel = ContentViewModel()
        viewModel.state = .authenticated
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        switch viewModel.state {
        case .idle:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
                .padding()
        case .unauthenticated:
            setUpView()
        case .authenticated:
            setUpView(isAuthenticated: true)
        case .authenticating:
            setUpView(isAuthenticating: true)
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

    private func setUpView(isAuthenticated: Bool = false, isAuthenticating: Bool = false) -> some View {
        NavigationView {
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 56.0)
                Spacer(minLength: 20.0)
                if isAuthenticated {
                    NavigationLink(destination: RewardListView(), isActive: $showRewardListView) {
                        PrimaryButton(
                            isEnabled: .constant(true),
                            isLoading: false,
                            action: {
                                showRewardListView.toggle()
                            },
                            title: "Rewards",
                            imageName: "gift.fill",
                            height: 56.0
                        )
                    }
                    NavigationLink(destination: RewardHistoryView(), isActive: $showRewardHistoryView) {
                        PrimaryButton(
                            isEnabled: .constant(true),
                            isLoading: false,
                            action: {
                                showRewardHistoryView.toggle()
                            },
                            title: "My Rewards",
                            imageName: "clock.fill",
                            height: 56.0
                        )
                    }
                    NavigationLink(destination: ProductListView(), isActive: $showProductListView) {
                        PrimaryButton(
                            isEnabled: .constant(true),
                            isLoading: false,
                            action: {
                                showProductListView.toggle()
                            },
                            title: "Product list",
                            imageName: "cart.fill",
                            height: 56.0
                        )
                    }
                    PrimaryButton(
                        isEnabled: .constant(true),
                        isLoading: false,
                        action: {
                            viewModel.signOut()
                        },
                        title: "Sign Out",
                        imageName: "rectangle.portrait.and.arrow.right.fill",
                        height: 56.0
                    )
                    .padding(.top, 20.0)
                } else {
                    PrimaryButton(
                        isEnabled: .constant(true),
                        isLoading: isAuthenticating,
                        action: {
                            viewModel.signIn()
                        },
                        title: "Sign In",
                        imageName: "person.fill",
                        height: 56.0
                    )
                }
                Spacer()
            }
            .padding(.horizontal, 40.0)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView(), isActive: $showCartView) {
                        CartButton {
                            showCartView.toggle()
                        }
                    }
                }
            }
        }
        .accentColor(Constants.Color.mirageBlack)
    }
}

struct ContentViewPreView: PreviewProvider {

    static var previews: some View {
        ContentView(forPreview: true)
    }
}
