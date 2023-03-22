//
//  APIRedeemReward.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//

import Foundation

public struct APIRedeemReward: Decodable {

    var id: String?
    var organizationId: String?
    var customerId: String?
    var rewardId: String?
    var state: String?
    var pointCost: Int?
    var createdAt: String?
    var updatedAt: String?
    var imageUrls: [String]?
    var reward: APIReward?
}
