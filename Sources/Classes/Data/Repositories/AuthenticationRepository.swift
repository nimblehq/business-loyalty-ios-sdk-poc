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
        let clientId: String = try! keychain.get(.clientId) ?? ""
        let clientSecret: String = try! keychain.get(.clientSecret) ?? ""
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

