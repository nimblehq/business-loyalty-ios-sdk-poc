//
//  CXTargetType.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation
import Moya

enum CXTargetType: Equatable {

    case getToken(code: String, clientId: String, clientSecret: String)
    case rewards
    case redeemRewards(code: String)
    case redeemHistory
}

extension CXTargetType: TargetType, AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }

    var baseURL: URL { URL(string: Constants.API.baseUrl)! }

    var path: String {
        switch self {
        case .getToken:
            return "oauth/token"
        case .rewards:
            return "rewards.json"
        case let .redeemRewards(id):
            return "rewards/\(id)/redeem.json"
        case .redeemHistory:
            return "redeemed_rewards.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getToken:
            return .post
        case .redeemRewards:
            return .patch
        case .rewards, .redeemHistory:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case let .getToken(code, clientId, clientSecret):
            return .requestParameters(
                parameters: [
                    "client_id": clientId,
                    "client_secret": clientSecret,
                    "code": code,
                    "code_verifier": "",
                    "grant_type": "authorization_code",
                    "redirect_uri": Constants.API.redirectURI
                ],
                encoding: URLEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    var headers: HTTPHeaders? {
        ["Accept": "application/json"]
    }
}
