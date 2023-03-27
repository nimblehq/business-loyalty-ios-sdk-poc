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

    @Environment(\.presentationMode) var presentationMode
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
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.rewards, id: \.self) { reward in
                        NavigationLink(
                            destination: RewardDetailView(
                                rewardCode: reward.id ?? ""
                            )
                        ) {
                            RewardItemView(
                                reward: reward,
                                action: { code in
                                    viewModel.redeemReward(code: code)
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Rewards")
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
            PrimaryButton(
                isEnabled: .constant(true),
                isLoading: false,
                action: {
                    action(reward.id ?? "")
                },
                title: "\(reward.pointCost ?? 0) Points"
            )
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
