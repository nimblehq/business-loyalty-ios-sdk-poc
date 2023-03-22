//
//  NimbleLoyaltySDK.swift
//  NimbleLoyaltySDK
//
//  Created by David Bui on 16/03/2023.
//

import AuthenticationServices

public enum NimbleLoyaltyError: Error {

    case alreadyAuthenticated
    case clientIdEmpty
    case clientSecretEmpty
    case failToCreateSignInURL
    case failToCreateCallbackURL
    case failToAuthenticate
    case failToGetAccessToken(String?)
    case failToStartASWebAuthenticationSession
}

extension NimbleLoyaltyError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .alreadyAuthenticated:
            return "Authenticated."
        case .clientIdEmpty:
            return "Client Id is empty"
        case .clientSecretEmpty:
            return "Client Secret is empty"
        case .failToCreateSignInURL:
            return "Could not create the sign in URL."
        case .failToCreateCallbackURL:
            return "Could not create the callback URL."
        case .failToAuthenticate:
            return "An error occurred when attempting to sign in."
        case let .failToGetAccessToken(error):
            return "Failed to exchange access code for tokens: \(error ?? "Unknown")"
        case .failToStartASWebAuthenticationSession:
            return "Failed to start ASWebAuthenticationSession"
        }
    }
}

public final class NimbleLoyalty {

    public static let shared = NimbleLoyalty()

    private let keychain = Keychain.default
    private let sessionManager = AuthenticationSessionManager()

    private init() {}

    public func setClientId(_ clientId: String) {
        guard !clientId.isEmpty else {
            fatalError(NimbleLoyaltyError.clientIdEmpty.localizedDescription)
        }
        try? keychain.set(clientId, for: .clientId)
    }

    public func setClientSecret(_ clientSecret: String) {
        guard !clientSecret.isEmpty else {
            fatalError(NimbleLoyaltyError.clientSecretEmpty.localizedDescription)
        }
        try? keychain.set(clientSecret, for: .clientSecret)
    }
}

//MARK: Public functions

extension NimbleLoyalty {

    public func isAuthenticated() -> Bool {
        sessionManager.isAuthenticated()
    }

    public func authenticate(_ completion: @escaping (Result<Void, NimbleLoyaltyError>) -> Void) {
        sessionManager.authenticate(completion)
    }

    public func clearSession() {
        sessionManager.clearSession()
    }
}


