//
//  RewardRepository.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Combine

final class RewardRepository: RewardRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol = NetworkAPI()) {
        self.networkAPI = networkAPI
    }

    func getRewardList() -> Observable<[Reward]> {
        networkAPI.performRequest(.rewards, for: [APIReward].self)
            .map { $0 as [Reward] }
            .asObservable()
    }

    func getRedeemedRewardHistory() -> Observable<[Reward]> {
        networkAPI.performRequest(.redeemHistory, for: [APIReward].self)
            .map { $0 as [Reward] }
            .asObservable()
    }

    func redeemReward(code: String) -> Observable<Reward> {
        networkAPI.performRequest(.redeemRewards(code: code), for: APIReward.self)
            .map { $0 as Reward }
            .asObservable()
    }
}
