//
//  APIOrderLineItem.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

public struct APIOrderLineItem: Decodable, Hashable {
    
    public var id: String
    public var organizationId: String?
    public var userId: String?
    public var productId: String?
    public var price: String?
    public var discount: String?
    public var tax: String?
    public var finalPrice: String?
    public var netPrice: String?
    public var quantity: Int?
    public var status: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var orderId: String?
    
    public static func == (lhs: APIOrderLineItem, rhs: APIOrderLineItem) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
