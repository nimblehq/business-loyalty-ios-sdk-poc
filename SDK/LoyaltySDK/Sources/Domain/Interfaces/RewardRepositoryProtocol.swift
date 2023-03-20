//
//  RewardRepository.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation

protocol RewardRepositoryProtocol: AnyObject {

    func getRewardList() -> Observable<[Reward]>
    func getRedeemedRewardHistory() -> Observable<[Reward]>
    func redeemReward(code: String) -> Observable<Reward>
}
