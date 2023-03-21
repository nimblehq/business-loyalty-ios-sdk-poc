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
        completion: @escaping RequestCompletion<T>
    ) where T : Decodable {
        provider.request(configuration) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    let data = try response.map(T.self, using: self.decoder)
                    completion(.success(data))
                } catch {
                    if let data = try? response.map(APIError.self, using: self.decoder) {
                        completion(.failure(data))
                    } else {
                        completion(.failure(APIError(error: error.localizedDescription)))
                    }
                }
            case let .failure(error):
                completion(.failure(APIError(error: error.localizedDescription)))
            }
        }
    }
}

