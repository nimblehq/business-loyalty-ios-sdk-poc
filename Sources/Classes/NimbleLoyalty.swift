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
            return "You've already been authenticated."
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

public final class NimbleLoyalty: NSObject {

    public static let shared = NimbleLoyalty()

    private let keyChain = Keychain.default
    private let authenticationRepository = AuthenticationRepository()

    private override init() {}

    public func setClientId(_ clientId: String) {
        guard !clientId.isEmpty else {
            fatalError(NimbleLoyaltyError.clientIdEmpty.localizedDescription)
        }
        try? keyChain.set(clientId, for: .clientId)
    }

    public func setClientSecret(_ clientSecret: String) {
        guard !clientSecret.isEmpty else {
            fatalError(NimbleLoyaltyError.clientSecretEmpty.localizedDescription)
        }
        try? keyChain.set(clientSecret, for: .clientSecret)
    }
}

//MARK: Public functions

extension NimbleLoyalty {

    public func isAuthenticated() -> Bool {
        guard let token: KeychainToken = try? keyChain.get(.userToken) else {
            return false
        }
        return true
    }

    public func authenticate(_ completion: @escaping (Result<Void, NimbleLoyaltyError>) -> Void) {
        guard !isAuthenticated() else {
            completion(.failure(NimbleLoyaltyError.alreadyAuthenticated))
            return
        }
        guard let clientId: String = try? keyChain.get(.clientId) else {
            completion(.failure(NimbleLoyaltyError.clientIdEmpty))
            return
        }
        guard let signInURL = URL(string: Constants.API.makeAuthRequestUrl(clientId: clientId)) else {
            completion(.failure(NimbleLoyaltyError.failToCreateSignInURL))
            return
        }

        guard let callbackURLScheme = URL(string: Constants.API.redirectUri)?.scheme else {
            completion(.failure(NimbleLoyaltyError.failToCreateCallbackURL))
            return
        }
        let authenticationSession = ASWebAuthenticationSession(
            url: signInURL,
            callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
                guard let self = self, error == nil, let callbackURL = callbackURL,
                      let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                      let code = queryItems.first(where: { $0.name == "code" })?.value
                else {
                    completion(.failure(NimbleLoyaltyError.failToAuthenticate))
                    return
                }

                self.authenticationRepository.getToken(code: code) { result in
                    switch result {
                    case let .success(token):
                        let keyChainToken = KeychainToken(token)
                        try? self.keyChain.set(keyChainToken, for: .userToken)
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(NimbleLoyaltyError.failToGetAccessToken(error.error)))
                    }
                }
            }

        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true

        if !authenticationSession.start() {
            completion(.failure(NimbleLoyaltyError.failToStartASWebAuthenticationSession))
        }
    }
}

// MARK: Authentication

extension NimbleLoyalty: ASWebAuthenticationPresentationContextProviding {

    public func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
