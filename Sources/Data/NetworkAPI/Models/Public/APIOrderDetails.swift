//
//  APIOrderDetails.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

public struct APIOrderDetails: Decodable, Hashable {

    public var id: String
    public var organizationId: String?
    public var userId: String?
    public var status: String?
    public var currency: String?
    public var subtotalPrice: String?
    public var finalPrice: String?
    public var shipmentCost: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var orderLineItems: [APIOrderLineItem]?

    public static func == (lhs: APIOrderDetails, rhs: APIOrderDetails) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
