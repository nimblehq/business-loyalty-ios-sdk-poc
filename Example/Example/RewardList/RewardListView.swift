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
                    if NimbleLoyalty.shared.isAuthenticated() {
                        viewModel.loadRewards()
                    } else {
                        viewModel.addDummies()
                    }
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
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
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
                .padding(.horizontal)
            }
        }
    }
}

struct RewardItemView: View {

    let reward: APIReward

    var action: (String) -> Void

    var body: some View {
        VStack(spacing: 8.0) {
            KFImage(URL(string: reward.imageUrls?.first ?? ""))
                .onFailureImage(UIImage(named: "logo_square"))
                .resizable()
                .scaledToFill()
                .frame(height: 126.0)
                .padding(.top, 8.0)
                .clipped()
            VStack(spacing: 4.0) {
                Text(reward.name ?? "")
                    .font(.system(size: 13.0))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Constants.Color.mirageBlack)
                    .lineLimit(1)
                Text(reward.description ?? "")
                    .font(.system(size: 13.0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Constants.Color.slateGray)
                    .lineLimit(2)
            }
            .padding(.horizontal, 8.0)
            Text("Until \(reward.expiresOn?.formatDate() ?? "")")
                .font(.system(size: 12.0))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Constants.Color.mirageBlack)
                .lineLimit(2)
                .padding(.horizontal, 8.0)
            Spacer(minLength: 0.0)
            HStack {
                Spacer()
                Button(action: {
                    action(reward.id ?? "")
                }) {
                    Text("\(reward.pointCost ?? 0) points")
                        .font(.system(size: 14.0))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8.0)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 32.0)
                .padding(.bottom, 8.0)
                .background(Constants.Color.havelockBlue)
                .cornerRadius(4.0)
                Spacer()
            }
            .padding(.bottom, 8.0)
        }
        .frame(height: 265.0)
        .border(Constants.Color.catskillWhite, width: 1.0)
        .cornerRadius(4.0)
        .background(Color.white)
    }
}

struct RewardListViewPreView: PreviewProvider {

    static var previews: some View {
        RewardListView()
    }
}
