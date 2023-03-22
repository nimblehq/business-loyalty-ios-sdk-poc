//
//  AuthenticationRepository.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//

final class AuthenticationRepository: AuthenticationRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol
    private var keychain: KeychainProtocol

    init(
        networkAPI: NetworkAPIProtocol = NetworkAPI(),
        keychain: KeychainProtocol = Keychain.default
    ) {
        self.networkAPI = networkAPI
        self.keychain = keychain
    }
    
    func getToken(code: String, _ completion: @escaping RequestCompletion<APIToken>) {
        guard let clientId: String = try? keychain.get(.clientId),
              let clientSecret: String = try? keychain.get(.clientSecret) else {
            completion(.failure(.init(error: "Missing client id or client secret")))
            return
        }
        networkAPI.performRequest(
            .getToken(
                code: code,
                clientId: clientId,
                clientSecret: clientSecret
            ),
            completion: completion
        )
    }
}

