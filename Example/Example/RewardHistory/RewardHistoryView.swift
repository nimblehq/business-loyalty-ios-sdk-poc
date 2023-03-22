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
            Text("Reward History")
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

    let reward: APIReward

    var body: some View {
        HStack(spacing: 10.0) {
            KFImage(URL(string: reward.imageUrls?.first ?? ""))
                .onFailureImage(UIImage(named: "logo_square"))
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 5) {
                Text(reward.name ?? "")
                    .font(.headline)
                Text(reward.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                Text("Redeemed: \(formatDate(reward.createdAt ?? ""))")
                    .font(.caption)
                HStack(spacing: 5) {
                    Text("\(reward.pointCost ?? 0) points")
                        .font(.caption)
                    Text("|")
                        .font(.caption)
                    Text("Expires: \(formatDate(reward.expiresOn ?? ""))")
                        .font(.caption)
                }
                Text(reward.state ?? "")
                    .font(.caption)
                    .foregroundColor(reward.state == "Redeemed" ? .green : .red)
            }
        }
    }

    private func formatDate(_ dateString: String, format: String = "MM/dd/yyyy") -> String {
        let isoFormatter = ISO8601DateFormatter()
        if let date = isoFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        } else {
            return "Invalid date string"
        }
    }
}

