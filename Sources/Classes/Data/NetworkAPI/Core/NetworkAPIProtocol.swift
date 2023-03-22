//
//  NetworkAPIProtocol.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Moya

protocol NetworkAPIProtocol {

    func performRequest<T: Decodable>(_ configuration: CXTargetType, completion: @escaping RequestCompletion<T>)
}
