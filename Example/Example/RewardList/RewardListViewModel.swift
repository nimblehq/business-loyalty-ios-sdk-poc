//
//  RewardListViewModel.swift
//  Example
//
//  Created by David Bui on 22/03/2023.
//

import Combine
import NimbleLoyalty

final class RewardListViewModel: ObservableObject {
    
    @Published var state: State = .idle
    @Published var rewards: [APIReward] = []
    
    func loadRewards() {
        NimbleLoyalty.shared.getRewardList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(rewardList):
                self.rewards = rewardList.rewards ?? []
                self.state = .loaded
            case let .failure(error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func redeemReward(code: String) {
        NimbleLoyalty.shared.redeemReward(code: code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.state = .redeemed
            case let .failure(error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func addDummies() {
        let dummyRewards: [APIReward] = [
            APIReward(
                id: "1",
                organizationId: "1",
                name: "Reward 1",
                description: "Description of reward 1.",
                conditions: "Conditions for reward 1.",
                instructions: "Instructions for redeeming reward 1.",
                terms: "Terms and conditions for reward 1.",
                type: "type 1",
                state: "active",
                expiresOn: "2023-12-31",
                pointCost: 100,
                createdAt: "2022-01-01",
                updatedAt: "2022-01-02",
                deletedAt: nil,
                redeemedRewardsCount: 0,
                imageUrls: ["https://example.com/reward1.jpg"]
            ),
            APIReward(
                id: "2",
                organizationId: "1",
                name: "Reward 2",
                description: "Description of reward 2.",
                conditions: "Conditions for reward 2.",
                instructions: "Instructions for redeeming reward 2.",
                terms: "Terms and conditions for reward 2.",
                type: "type 2",
                state: "active",
                expiresOn: "2023-12-31",
                pointCost: 200,
                createdAt: "2022-01-01",
                updatedAt: "2022-01-02",
                deletedAt: nil,
                redeemedRewardsCount: 0,
                imageUrls: ["https://example.com/reward2.jpg"]
            ),
            APIReward(
                id: "3",
                organizationId: "1",
                name: "Reward 1",
                description: "Description of reward 1.",
                conditions: "Conditions for reward 1.",
                instructions: "Instructions for redeeming reward 1.",
                terms: "Terms and conditions for reward 1.",
                type: "type 1",
                state: "active",
                expiresOn: "2023-12-31",
                pointCost: 100,
                createdAt: "2022-01-01",
                updatedAt: "2022-01-02",
                deletedAt: nil,
                redeemedRewardsCount: 0,
                imageUrls: ["https://example.com/reward1.jpg"]
            ),
            APIReward(
                id: "4",
                organizationId: "1",
                name: "Reward 2",
                description: "Description of reward 2.",
                conditions: "Conditions for reward 2.",
                instructions: "Instructions for redeeming reward 2.",
                terms: "Terms and conditions for reward 2.",
                type: "type 2",
                state: "active",
                expiresOn: "2023-12-31",
                pointCost: 200,
                createdAt: "2022-01-01",
                updatedAt: "2022-01-02",
                deletedAt: nil,
                redeemedRewardsCount: 0,
                imageUrls: ["https://example.com/reward2.jpg"]
            ),
            APIReward(
                id: "5",
                organizationId: "1",
                name: "Reward 1",
                description: "Description of reward 1.",
                conditions: "Conditions for reward 1.",
                instructions: "Instructions for redeeming reward 1.",
                terms: "Terms and conditions for reward 1.",
                type: "type 1",
                state: "active",
                expiresOn: "2023-12-31",
                pointCost: 100,
                createdAt: "2022-01-01",
                updatedAt: "2022-01-02",
                deletedAt: nil,
                redeemedRewardsCount: 0,
                imageUrls: ["https://example.com/reward1.jpg"]
            ),
            APIReward(
                id: "6",
                organizationId: "1",
                name: "Reward 2",
                description: "Description of reward 2.",
                conditions: "Conditions for reward 2.",
                instructions: "Instructions for redeeming reward 2.",
                terms: "Terms and conditions for reward 2.",
                type: "type 2",
                state: "active",
                expiresOn: "2023-12-31",
                pointCost: 200,
                createdAt: "2022-01-01",
                updatedAt: "2022-01-02",
                deletedAt: nil,
                redeemedRewardsCount: 0,
                imageUrls: ["https://example.com/reward2.jpg"]
            ),
        ]
        rewards = dummyRewards
        state = .loaded
    }
}

extension RewardListViewModel {
    
    enum State: Equatable {
        
        case idle, loaded, redeemed
        case error(String)
    }
}


