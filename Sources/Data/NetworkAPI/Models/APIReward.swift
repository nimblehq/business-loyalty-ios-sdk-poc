//
//  APIReward.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation

public struct APIReward: Decodable, Hashable {

    public var id: String?
    public var organizationId: String?
    public var name: String?
    public var description: String?
    public var conditions: String?
    public var instructions: String?
    public var terms: String?
    public var type: String?
    public var state: String?
    public var expiresOn: String?
    public var pointCost: Int?
    public var createdAt: String?
    public var updatedAt: String?
    public var deletedAt: String?
    public var redeemedRewardsCount: Int?
    public var imageUrls: [String]?

    public init(id: String? = nil, organizationId: String? = nil, name: String? = nil, description: String? = nil, conditions: String? = nil, instructions: String? = nil, terms: String? = nil, type: String? = nil, state: String? = nil, expiresOn: String? = nil, pointCost: Int? = nil, createdAt: String? = nil, updatedAt: String? = nil, deletedAt: String? = nil, redeemedRewardsCount: Int? = nil, imageUrls: [String]? = nil) {
        self.id = id
        self.organizationId = organizationId
        self.name = name
        self.description = description
        self.conditions = conditions
        self.instructions = instructions
        self.terms = terms
        self.type = type
        self.state = state
        self.expiresOn = expiresOn
        self.pointCost = pointCost
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
        self.redeemedRewardsCount = redeemedRewardsCount
        self.imageUrls = imageUrls
    }
}
