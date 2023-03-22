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
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 56)
            Spacer(minLength: 20.0)
            if isAuthenticated {
                Button(action: {
                    showRewardListView.toggle()
                }) {
                    Text("Reward List")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                Button(action: {
                    // Handle button tap-action
                }) {
                    Text("Reward History")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Clear Session")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 20.0)
            } else {
                Button(action: {
                    viewModel.signIn()
                }) {
                    Text("Sign in")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showRewardListView) {
            RewardListView()
        }
    }
}

struct ContentViewPreView: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
