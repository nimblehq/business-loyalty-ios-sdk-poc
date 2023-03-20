//
//  NetworkAPI.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Combine
import Moya

final class NetworkAPI: NetworkAPIProtocol {

    private let keychain = Keychain.default
    private let provider = MoyaProvider<RequestConfiguration>(plugins: [AuthPlugin()])
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func performRequest<T>(
        _ configuration: RequestConfiguration,
        for type: T.Type
    ) -> Observable<T> where T: Decodable {
        provider.requestPublisher(configuration)
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .asObservable()
    }
}

