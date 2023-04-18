//
//  APIProduct.swift
//  
//
//  Created by Edgars Simanovskis on 17/4/23.
//

import Foundation

public struct APIProduct: Decodable, Hashable {

    public var id: String
    public var organizationId: String?
    public var name: String?
    public var sku: String?
    public var description: String?
    public var price: String?
    public var displayPrice: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var imageUrl: String?

    public static func == (lhs: APIProduct, rhs: APIProduct) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
