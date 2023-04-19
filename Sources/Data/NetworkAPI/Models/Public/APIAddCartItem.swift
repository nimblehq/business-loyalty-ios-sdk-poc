//
//  APIAddCartItem.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

public struct APIAddCartItem: Hashable {

    public var productId: String
    public var quantity: Int
    
    public static func == (lhs: APIAddCartItem, rhs: APIAddCartItem) -> Bool {
        lhs.productId == rhs.productId
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(productId)
    }
}
