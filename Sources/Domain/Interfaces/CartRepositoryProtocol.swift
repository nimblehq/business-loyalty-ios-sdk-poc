//
//  CartRepositoryProtocol.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

protocol CartRepositoryProtocol: AnyObject {
    
    func getCartDetails(_ completion: @escaping RequestCompletion<APICart>)
    func addCartItem(item: APIAddCartItem, _ completion: @escaping RequestCompletion<APICart>)
    func updateCartItem(item: APIUpdateCartItemQuantity, _ completion: @escaping RequestCompletion<APICart>)
    func removeCartItem(id: String, _ completion: @escaping RequestCompletion<APICart>)
}
