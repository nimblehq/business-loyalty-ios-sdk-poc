//
//  NetworkAPI.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Moya

final class NetworkAPI: NetworkAPIProtocol {

    private let keychain = Keychain.default
    private let provider = MoyaProvider<CXTargetType>(plugins: [AuthPlugin()])
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func performRequest<T>(
        _ configuration: CXTargetType,
        completion: @escaping RequestCompletion<T>
    ) where T : Decodable {
        provider.request(configuration) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    Self.prettyPrintJsonData(filteredResponse.data)
                    let data = try filteredResponse.map(T.self, using: self.decoder)
                    completion(.success(data))
                } catch {
                    if let data = try? response.map(APIError.self, using: self.decoder) {
                        completion(.failure(NimbleLoyaltyError.api(data.error ?? "")))
                    } else if response.statusCode == 401 {
                        completion(.failure(NimbleLoyaltyError.unauthenticated))
                    } else {
                        completion(.failure(NimbleLoyaltyError.api(error.localizedDescription)))
                    }
                }
            case let .failure(error):
                completion(.failure(NimbleLoyaltyError.api(error.localizedDescription)))
            }
        }
    }

    static func prettyPrintJsonData(_ data: Data) {
        let stringData = String(data: data, encoding: .utf8) ?? ""
        print(stringData)
    }
}

