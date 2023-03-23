//
//  RewardHistoryViewModel.swift
//  Example
//
//  Created by David Bui on 22/03/2023.
//

import Combine
import NimbleLoyalty

final class RewardHistoryViewModel: ObservableObject {

    @Published var state: State = .idle
    @Published var rewards: [APIRedeemReward] = []

    func loadRewardHistory() {
        NimbleLoyalty.shared.getRewardHistory { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(redeemRewards):
                self.rewards = redeemRewards
                self.state = .loaded
            case let .failure(error):
                self.state = .error(error.localizedDescription)
            }
        }
    }

    func addDummies() {
        let dummyRewards: [APIRedeemReward] = [
            APIRedeemReward(id: "1", organizationId: "1", customerId: "1", rewardId: "1", state: "completed", pointCost: 100, createdAt: "2022-03-23T10:00:00.000Z", updatedAt: "2022-03-23T10:00:00.000Z", images: "image1.jpg", reward: APIReward(id: "1", organizationId: "1", name: "Reward 1", description: "Description of reward 1", conditions: "Conditions of reward 1", instructions: "Instructions for reward 1", terms: "Terms of reward 1", type: "type1", state: "state1", expiresOn: "2023-03-23T10:00:00.000Z", pointCost: 100, createdAt: "2022-03-23T10:00:00.000Z", updatedAt: "2022-03-23T10:00:00.000Z", deletedAt: nil, redeemedRewardsCount: 0, imageUrls: ["image1.jpg"])),
            APIRedeemReward(id: "2", organizationId: "1", customerId: "2", rewardId: "2", state: "completed", pointCost: 200, createdAt: "2022-03-22T11:00:00.000Z", updatedAt: "2022-03-22T11:00:00.000Z", images: "image2.jpg", reward: APIReward(id: "2", organizationId: "1", name: "Reward 2", description: "Description of reward 2", conditions: "Conditions of reward 2", instructions: "Instructions for reward 2", terms: "Terms of reward 2", type: "type2", state: "state2", expiresOn: "2023-03-22T11:00:00.000Z", pointCost: 200, createdAt: "2022-03-22T11:00:00.000Z", updatedAt: "2022-03-22T11:00:00.000Z", deletedAt: nil, redeemedRewardsCount: 0, imageUrls: ["image2.jpg"]))
        ]
        rewards = dummyRewards
        state = .loaded
    }
}

extension RewardHistoryViewModel {

    enum State: Equatable {

        case idle, loaded
        case error(String)
    }
}



