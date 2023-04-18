//
//  RewardRepository.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation

protocol RewardRepositoryProtocol: AnyObject {

    func getRewardList(_ completion: @escaping RequestCompletion<APIRewardList>)
    func getRewardDetail(code: String, _ completion: @escaping RequestCompletion<APIReward>)
    func getRedeemedRewardHistory(_ completion: @escaping RequestCompletion<[APIRedeemReward]>)
    func redeemReward(code: String, _ completion: @escaping RequestCompletion<APIRedeemReward>)
}
