//
//  RewardHistoryView.swift
//  Example
//
//  Created by David Bui on 22/03/2023.
//

import Kingfisher
import NimbleLoyalty
import SwiftUI

struct RewardHistoryView: View {

    @StateObject private var viewModel = RewardHistoryViewModel()

    var body: some View {
        switch viewModel.state {
        case .idle:
            setUpView()
                .onAppear {
                    if NimbleLoyalty.shared.isAuthenticated() {
                        viewModel.loadRewardHistory()
                    } else {
                        viewModel.addDummies()
                    }
                }
        case .loaded:
            setUpView()
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
            Text("My Rewards")
                .font(.largeTitle)
                .frame(height: 24.0)
                .padding(.vertical, 20.0)
            ScrollView {
                VStack(spacing: 16.0) {
                    ForEach(viewModel.rewards.indices, id: \.self) { index in
                        RewardHistoryItemView(
                            reward: viewModel.rewards[index]
                        )
                        .tag(index)
                    }
                }
            }
        }
    }
}

struct RewardHistoryItemView: View {

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    let reward: APIRedeemReward

    struct RewardHistoryCell: View {
        var body: some View {
            HStack(spacing: 16) {
                Image("example-image")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .cornerRadius(10)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Reward Name")
                        .font(.headline)
                    Text("Expires on 31 Dec 2022")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                Button(action: {
                    // Redeem button action
                }) {
                    Text("Use")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .frame(height: 72)
            .padding(.horizontal, 16)
            .background(Color.white)
            .overlay(
                Divider(),
                alignment: .bottom
            )
        }
    }

    var body: some View {
        VStack(spacing: 16.0) {
            HStack(alignment: .center, spacing: 16.0) {
                KFImage(URL(string: reward.reward?.imageUrls?.first ?? ""))
                    .onFailureImage(UIImage(named: "logo_square"))
                    .resizable()
                    .frame(width: 56.0, height: 56.0)
                    .cornerRadius(4.0)
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(reward.reward?.name ?? "")
                        .font(.system(size: 13.0))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Constants.Color.mirageBlack)
                        .lineLimit(2)
                    Text("Until \(reward.reward?.expiresOn?.formatDate() ?? "")")
                        .font(.system(size: 13.0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Constants.Color.slateGray)
                        .lineLimit(1)
                }
                Spacer(minLength: 0.0)
                Button(action: {
                    // Use action
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

