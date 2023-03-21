//
//  RequestConfiguration.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Foundation
import Moya

enum RequestConfiguration: Equatable {

    case getToken(token: String)
    case rewards
    case redeemRewards(code: String)
    case redeemHistory
}

extension RequestConfiguration: TargetType, AccessTokenAuthorizable {

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
        return .requestPlain
    }

    var headers: HTTPHeaders? {
        ["Accept": "application/json"]
    }
}
