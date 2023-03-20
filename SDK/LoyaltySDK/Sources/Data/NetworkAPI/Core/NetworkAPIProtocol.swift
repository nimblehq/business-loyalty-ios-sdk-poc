//
//  NetworkAPIProtocol.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Combine
import Moya

protocol NetworkAPIProtocol {

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for type: T.Type) -> Observable<T>
}
