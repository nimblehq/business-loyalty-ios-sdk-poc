//
//  OrderRepository.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

final class OrderRepository: OrderRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol = NetworkAPI()) {
        self.networkAPI = networkAPI
    }

    func getOrderList(_ completion: @escaping RequestCompletion<[APIOrder]>) {
        networkAPI.performRequest(.orders, completion: completion)
    }
    
    func getOrderDetails(orderId: String, _ completion: @escaping RequestCompletion<APIOrderDetails>) {
        networkAPI.performRequest(.orderDetail(orderId: orderId), completion: completion)
    }
    
    func submitOrder(cartId: String, _ completion: @escaping RequestCompletion<APIOrderDetails>) {
        networkAPI.performRequest(.submitOrder(cartId: cartId), completion: completion)
    }
}
