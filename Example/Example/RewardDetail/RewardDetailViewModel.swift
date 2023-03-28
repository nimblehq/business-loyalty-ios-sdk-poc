//
//  RewardDetailViewModel.swift
//  Example
//
//  Created by David Bui on 27/03/2023.
//

import Combine
import NimbleLoyalty

final class RewardDetailViewModel: ObservableObject {

    @Published var state: State = .idle
    @Published var rewardCode: String
    @Published var reward: APIReward?

    init(rewardCode: String) {
        self.rewardCode = rewardCode
    }

    func loadRewardDetail() {
        state = .loading
        NimbleLoyalty.shared.getRewardDetail(code: rewardCode) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(rewardDetail):
                self.reward = rewardDetail
                self.state = .loaded
            case let .failure(error):
                self.state = .error(error.localizedDescription)
            }
        }
    }

    func redeemReward() {
        state = .redeeming
        NimbleLoyalty.shared.redeemReward(code: rewardCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.state = .redeemed
            case let .failure(error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
}

extension RewardDetailViewModel {

    enum State: Equatable {

        case idle, loaded, loading, redeeming, redeemed
        case error(String)
    }
}


