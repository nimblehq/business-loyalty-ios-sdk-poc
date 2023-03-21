//
//  APIReward.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation

public struct APIReward: Decodable {

    var id: String?
    var organizationId: String?
    var name: String?
    var description: String?
    var conditions: String?
    var instructions: String?
    var terms: String?
    var type: String?
    var state: String?
    var expiresOn: String?
    var pointCost: Int?
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    var redeemedRewardsCount: Int?
    var imageUrls: [String]?
}
