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
        state = .loading
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
}

extension RewardHistoryViewModel {

    enum State: Equatable {

        case idle, loaded, loading
        case error(String)
    }
}



