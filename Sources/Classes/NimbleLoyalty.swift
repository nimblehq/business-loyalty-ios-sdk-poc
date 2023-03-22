//
//  NimbleLoyaltySDK.swift
//  NimbleLoyaltySDK
//
//  Created by David Bui on 16/03/2023.
//

import AuthenticationServices

public final class NimbleLoyalty: NSObject {

    public static let shared = NimbleLoyalty()

    private let keyChain = Keychain.default
    private let authenticationRepository = AuthenticationRepository()

    private override init() {}

    public func setClientId(_ clientId: String) {
        guard !clientId.isEmpty else {
            fatalError("Client Id must not be empty")
        }
        try? keyChain.set(clientId, for: .clientId)
    }

    public func setClientSecret(_ clientSecret: String) {
        guard !clientSecret.isEmpty else {
            fatalError("Client Secret must not be empty")
        }
        try? keyChain.set(clientSecret, for: .clientSecret)
    }
}

//MARK: Public functions

extension NimbleLoyalty {

    public func signIn() {
        guard let clientId: String = try? keyChain.get(.clientId) else {
            fatalError("Client Id must not be empty")
        }
        guard let signInURL = URL(string: Constants.API.makeAuthRequestUrl(clientId: clientId)) else {
            fatalError("Could not create the sign in URL.")
        }

        guard let callbackURLScheme = URL(string: Constants.API.redirectUri)?.scheme else {
            fatalError("Could not create the callback URL.")
        }
        let authenticationSession = ASWebAuthenticationSession(
            url: signInURL,
            callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
                guard let self = self, error == nil, let callbackURL = callbackURL,
                      let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                      let code = queryItems.first(where: { $0.name == "code" })?.value
                else {
                    fatalError("An error occurred when attempting to sign in.")
                }

                self.authenticationRepository.getToken(code: code) { result in
                    switch result {
                    case let .success(token):
                        let keyChainToken = KeychainToken(token)
                        try? self.keyChain.set(keyChainToken, for: .userToken)
                    case .failure(let error):
                        print("Failed to exchange access code for tokens: \(error)")
                    }
                }
            }

        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true

        if !authenticationSession.start() {
            print("Failed to start ASWebAuthenticationSession")
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
