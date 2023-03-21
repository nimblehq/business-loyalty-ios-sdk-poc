//
//  AuthenticationRepository.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//

final class AuthenticationRepository: AuthenticationRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol = NetworkAPI()) {
        self.networkAPI = networkAPI
    }

    func getToken(authToken: String, _ completion: @escaping RequestCompletion<APIToken>) {
        networkAPI.performRequest(.getToken(token: authToken), completion: completion)
    }
}

