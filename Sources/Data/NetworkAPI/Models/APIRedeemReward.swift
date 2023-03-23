//
//  APIRedeemReward.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//

import Foundation

public struct APIRedeemReward: Decodable {

    public var id: String?
    public var organizationId: String?
    public var customerId: String?
    public var rewardId: String?
    public var state: String?
    public var pointCost: Int?
    public var createdAt: String?
    public var updatedAt: String?
    public var images: String?
    public var reward: APIReward?

    public init(id: String? = nil, organizationId: String? = nil, customerId: String? = nil, rewardId: String? = nil, state: String? = nil, pointCost: Int? = nil, createdAt: String? = nil, updatedAt: String? = nil, images: String? = nil, reward: APIReward? = nil) {
        self.id = id
        self.organizationId = organizationId
        self.customerId = customerId
        self.rewardId = rewardId
        self.state = state
        self.pointCost = pointCost
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.images = images
        self.reward = reward
    }
}
