//
//  NimbleLoyaltySDK.swift
//  NimbleLoyaltySDK
//
//  Created by David Bui on 16/03/2023.
//

import Foundation

public final class NimbleLoyalty {

    public static let shared = NimbleLoyalty()

    private let keychain = Keychain.default

    private init() {}

    public func setClientId(_ clientId: String) {
        guard !clientId.isEmpty else {
            fatalError("Client Id must not be empty")
        }
        try? keychain.set(clientId, for: .clientId)
    }

    public func setClientSecret(_ clientSecret: String) {
        guard !clientSecret.isEmpty else {
            fatalError("Client Secret must not be empty")
        }
        try? keychain.set(clientSecret, for: .clientSecret)
    }
}
