//
//  AuthPlugin.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Moya

struct AuthPlugin: PluginType {

    private var keychain: KeychainProtocol = Keychain.default

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let token: String = try? keychain.get(.userToken), !token.isEmpty {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

