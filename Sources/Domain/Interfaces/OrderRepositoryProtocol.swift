//
//  OrderRepositoryProtocol.swift
//  NimbleLoyalty
//
//  Created by Edgars Simanovskis on 19/4/23.
//

import Foundation

protocol OrderRepositoryProtocol: AnyObject {
    
    func getOrderList(_ completion: @escaping RequestCompletion<[APIOrder]>)
    func getOrderDetails(orderId: String, _ completion: @escaping RequestCompletion<APIOrderDetails>)
    func submitOrder(cartId: String, _ completion: @escaping RequestCompletion<APIOrderDetails>)
}
