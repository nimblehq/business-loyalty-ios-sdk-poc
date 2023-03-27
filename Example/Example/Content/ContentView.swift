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

    private func setUpView(isAuthenticated: Bool = false) -> some View {
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
                            height: 56.0
                        )
                    }
                    PrimaryButton(
                        isEnabled: .constant(true),
                        isLoading: false,
                        action: {
                            viewModel.signOut()
                        },
                        title: "Clear Session",
                        height: 56.0
                    )
                    .padding(.top, 20.0)
                } else {
                    PrimaryButton(
                        isEnabled: .constant(true),
                        isLoading: false,
                        action: {
                            viewModel.signIn()
                        },
                        title: "Authenticate",
                        height: 56.0
                    )
                }
                Spacer()
            }
            .padding()
        }
        .accentColor(Constants.Color.havelockBlue)
    }
}

struct ContentViewPreView: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
