//
//  APIReward.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation

struct APIReward: Decodable, Reward {

    var id: String?
    var organizationId: String?
    var name: String?
    var description: String?
    var conditions: String?
    var instructions: String?
    var terms: String?
    var type: RewardType?
    var state: RewardState?
    var expiresOn: String?
    var pointCost: Int?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    var redeemedRewardsCount: Int?
    var imageUrls: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case organizationId = "organization_id"
        case name, description, conditions, instructions, terms, type, state
        case expiresOn = "expires_on"
        case pointCost = "point_cost"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case redeemedRewardsCount = "redeemed_rewards_count"
        case imageUrls = "image_urls"
    }
}
