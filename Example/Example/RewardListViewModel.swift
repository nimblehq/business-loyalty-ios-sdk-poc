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
}

extension RewardListViewModel {

    enum State: Equatable {

        case idle, loaded
        case error(String)
    }
}


