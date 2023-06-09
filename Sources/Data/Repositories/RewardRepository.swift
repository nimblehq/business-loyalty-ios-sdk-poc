//
//  RewardRepository.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

final class RewardRepository: RewardRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol = NetworkAPI()) {
        self.networkAPI = networkAPI
    }

    func getRewardList(_ completion: @escaping RequestCompletion<APIRewardList>) {
        networkAPI.performRequest(.rewards, completion: completion)
    }

    func getRewardDetail(code: String, _ completion: @escaping RequestCompletion<APIReward>) {
        networkAPI.performRequest(.rewardDetail(code: code), completion: completion)
    }

    func getRedeemedRewardHistory(_ completion: @escaping RequestCompletion<[APIRedeemReward]>) {
        networkAPI.performRequest(.redeemHistory, completion: completion)
    }

    func redeemReward(code: String, _ completion: @escaping RequestCompletion<APIRedeemReward>) {
        networkAPI.performRequest(.redeemRewards(code: code), completion: completion)
    }
}
