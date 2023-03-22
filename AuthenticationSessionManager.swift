//
//  AuthenticationSessionManager.swift
//  NimbleLoyalty
//
//  Created by David Bui on 22/03/2023.
//

import AuthenticationServices

final class AuthenticationSessionManager: NSObject {

    private let keychain = Keychain.default
    private let authenticationRepository = AuthenticationRepository()
}

//MARK: Public functions

extension AuthenticationSessionManager {

    func isAuthenticated() -> Bool {
        guard let token: KeychainToken = try? keychain.get(.userToken) else {
            return false
        }
        return true
    }
    
    func authenticate(_ completion: @escaping (Result<Void, NimbleLoyaltyError>) -> Void) {
        guard !isAuthenticated() else {
            completion(.failure(NimbleLoyaltyError.alreadyAuthenticated))
            return
        }
        guard let clientId: String = try? keychain.get(.clientId) else {
            completion(.failure(NimbleLoyaltyError.clientIdEmpty))
            return
        }
        guard let signInURL = URL(string: Constants.API.makeAuthRequestUrl(clientId: clientId)) else {
            completion(.failure(NimbleLoyaltyError.failToCreateSignInURL))
            return
        }

        guard let callbackURLScheme = URL(string: Constants.API.redirectURI)?.scheme else {
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
                        try? self.keychain.set(keyChainToken, for: .userToken)
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

    func clearSession() {
        try? keychain.remove(.userToken)
    }
}

// MARK: Authentication

extension AuthenticationSessionManager: ASWebAuthenticationPresentationContextProviding {

    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
