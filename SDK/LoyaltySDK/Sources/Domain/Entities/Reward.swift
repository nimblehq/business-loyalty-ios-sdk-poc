//
//  Reward.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation

protocol Reward {

    var id: String? { get }
    var organizationId: String? { get }
    var name: String? { get }
    var description: String? { get }
    var conditions: String? { get }
    var instructions: String? { get }
    var terms: String? { get } 
    var type: RewardType? { get }
    var state: RewardState? { get }
    var expiresOn: String? { get }
    var pointCost: Int? { get }
    var createdAt: String? { get }
    var updatedAt: String? { get }
    var deletedAt: String? { get }
    var redeemedRewardsCount: Int? { get }
    var imageUrls: [String]? { get }
}
