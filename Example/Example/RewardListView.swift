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
        VStack(spacing: 16.0) {
            ForEach(viewModel.rewards.indices, id: \.self) { index in
                RewardItemView(reward: viewModel.rewards[index])
                    .tag(index)
            }
        }
    }
}

struct RewardItemView: View {

    let reward: APIReward

    var body: some View {
        HStack {
            KFImage(URL(string: reward.imageUrls?.first ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()
            VStack(alignment: .leading) {
                Text(reward.name ?? "")
                    .font(.headline)
                Text(reward.description ?? "")
                    .font(.subheadline)
                Spacer()
                HStack {
                    Text("\(reward.pointCost ?? 0) points")
                        .font(.subheadline)
                    Spacer()
                    Text(reward.type ?? "")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
            .padding(.vertical)
            if reward.state != "active" {
                Image(systemName: "lock.fill")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}
