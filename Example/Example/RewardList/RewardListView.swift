//
//  RewardListView.swift
//  Example
//
//  Created by David Bui on 22/03/2023.
//

import Kingfisher
import NimbleLoyalty
import SwiftUI

struct RewardListView: View {

    @StateObject private var viewModel = RewardListViewModel()

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    viewModel.loadRewards()
                }
        case .loaded:
            setUpView()
        case .redeemed:
            setUpView()
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("Example"),
                        message: Text("Redeem reward successfully"),
                        dismissButton: Alert.Button.default(
                            Text("OK"),
                            action: {
                                viewModel.state = .loaded
                            }
                        )
                    )
                }
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

    private func setUpView() -> some View {
        VStack {
            Text("Rewards")
                .font(.largeTitle)
                .frame(height: 24.0)
                .padding(.vertical, 20.0)
            ScrollView {
                VStack(spacing: 16.0) {
                    ForEach(viewModel.rewards.indices, id: \.self) { index in
                        RewardItemView(
                            reward: viewModel.rewards[index],
                            action: { code in
                                viewModel.redeemReward(code: code)
                            }
                        )
                        .tag(index)
                    }
                }
            }
        }
    }
}

struct RewardItemView: View {

    let reward: APIReward

    var action: (String) -> Void

    var body: some View {
        VStack {
            KFImage(URL(string: reward.imageUrls?.first ?? ""))
                .onFailureImage(UIImage(named: "logo_square"))
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.top, 8.0)

            VStack(alignment: .leading, spacing: 8) {
                Text(reward.name ?? "")
                    .font(.headline)
                Text(reward.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                HStack {
                    Text("\(reward.pointCost ?? 0) Points")
                        .font(.caption)
                        .foregroundColor(.orange)
                    Spacer()
                    Text(reward.type ?? "")
                        .font(.caption)
                        .foregroundColor(.red)
                    Text(reward.state ?? "")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                Button(action: {
                    action(reward.id ?? "")
                }) {
                    Text("Redeem")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
