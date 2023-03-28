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
    public var status: String?
    public var pointCost: Int?
    public var images: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var reward: APIReward?
}
