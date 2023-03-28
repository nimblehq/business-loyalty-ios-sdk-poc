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
}
