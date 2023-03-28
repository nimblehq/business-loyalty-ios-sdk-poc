//
//  NimbleLoyaltySDK.swift
//  NimbleLoyaltySDK
//
//  Created by David Bui on 16/03/2023.
//

import AuthenticationServices

public enum NimbleLoyaltyError: Error {

    case api(String)
    case clientIdEmpty
    case clientSecretEmpty
    case failToCreateSignInURL
    case failToCreateCallbackURL
    case failToAuthenticate
    case failToStartASWebAuthenticationSession
    case unauthenticated
}

extension NimbleLoyaltyError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case let .api(error):
            return error
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
        case .failToStartASWebAuthenticationSession:
            return "Failed to start ASWebAuthenticationSession"
        case .unauthenticated:
            return "Unauthorized access. Please authenticate."
        }
    }
}

public final class NimbleLoyalty {

    public static let shared = NimbleLoyalty()

    private let keychain = Keychain.default
    private let sessionManager = AuthenticationSessionManager()
    private let rewardRepository = RewardRepository()

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

    public func getRewardList(_ completion: @escaping (Result<APIRewardList, NimbleLoyaltyError>) -> Void) {
        guard isAuthenticated() else {
            completion(.failure(NimbleLoyaltyError.unauthenticated))
            return
        }
        rewardRepository.getRewardList { result in
            switch result {
            case let .success(rewardList):
                completion(.success(rewardList))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func getRewardDetail(code: String, _ completion: @escaping (Result<APIReward, NimbleLoyaltyError>) -> Void) {
        guard isAuthenticated() else {
            completion(.failure(NimbleLoyaltyError.unauthenticated))
            return
        }
        rewardRepository.getRewardDetail(code: code) { result in
            switch result {
            case let .success(rewardDetail):
                completion(.success(rewardDetail))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func redeemReward(code: String, _ completion: @escaping (Result<APIRedeemReward, NimbleLoyaltyError>) -> Void) {
        guard isAuthenticated() else {
            completion(.failure(NimbleLoyaltyError.unauthenticated))
            return
        }
        rewardRepository.redeemReward(code: code) { result in
            switch result {
            case let .success(redeemReward):
                completion(.success(redeemReward))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    public func getRewardHistory(_ completion: @escaping (Result<[APIRedeemReward], NimbleLoyaltyError>) -> Void) {
        guard isAuthenticated() else {
            completion(.failure(NimbleLoyaltyError.unauthenticated))
            return
        }
        rewardRepository.getRedeemedRewardHistory() { result in
            switch result {
            case let .success(redeemRewardList):
                completion(.success(redeemRewardList))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


