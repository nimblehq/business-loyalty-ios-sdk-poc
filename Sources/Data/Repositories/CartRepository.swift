//
//  CartRepository.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

final class CartRepository: CartRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol = NetworkAPI()) {
        self.networkAPI = networkAPI
    }

    
    func getCartDetails(_ completion: @escaping RequestCompletion<APICart>) {
        networkAPI.performRequest(.cartDetails, completion: completion)
    }
    
    func addCartItem(item: APIAddCartItem, _ completion: @escaping RequestCompletion<APICart>) {
        networkAPI.performRequest(.addCartItem(item: item), completion: completion)
    }
    
    func updateCartItem(item: APIUpdateCartItemQuantity, _ completion: @escaping RequestCompletion<APICart>) {
        networkAPI.performRequest(.updateCartItem(item: item), completion: completion)
    }
    
    func removeCartItem(id: String, _ completion: @escaping RequestCompletion<APICart>) {
        networkAPI.performRequest(.removeCartItem(id: id), completion: completion)
    }
}
