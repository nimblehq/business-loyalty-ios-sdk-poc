//
//  NetworkAPI.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Combine
import Moya

final class NetworkAPI: NetworkAPIProtocol {

    enum DecoderType {

        case emptyJson, jsonAPI
    }

    enum StatusCode: Int {

        case unauthenticated = 401
    }

    private var keychain: KeychainProtocol
    private var notificationCenter: NotificationCenter
    private let provider: MoyaProvider<RequestConfiguration>
    private let decoder: JSONDecoder

    init(
        keychain: KeychainProtocol = Keychain.default,
        notificationCenter: NotificationCenter = NotificationCenter.default,
        provider: MoyaProvider<RequestConfiguration> = MoyaProvider<RequestConfiguration>(plugins: [AuthPlugin()]),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.keychain = keychain
        self.notificationCenter = notificationCenter
        self.provider = provider
        self.decoder = decoder
    }

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

