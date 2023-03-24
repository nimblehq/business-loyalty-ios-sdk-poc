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
                    viewModel.loadRewardHistory()
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("My Rewards")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Constants.Color.havelockBlue)
                        .frame(height: 24.0)
                        .padding(.vertical, 20.0)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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

