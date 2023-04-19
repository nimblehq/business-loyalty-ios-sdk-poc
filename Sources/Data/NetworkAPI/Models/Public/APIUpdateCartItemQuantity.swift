//
//  APIUpdateCartItemQuantity.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

public struct APIUpdateCartItemQuantity: Hashable {

    public var lineItemId: String
    public var quantity: Int
    
    public static func == (lhs: APIUpdateCartItemQuantity, rhs: APIUpdateCartItemQuantity) -> Bool {
        lhs.lineItemId == rhs.lineItemId
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(lineItemId)
    }
}
