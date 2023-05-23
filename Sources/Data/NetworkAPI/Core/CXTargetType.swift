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
    case rewardDetail(code: String)
    case redeemRewards(code: String)
    case redeemHistory
    case products
    case productDetail(id: String)
    case orders
    case orderDetail(orderId: String)
    case submitOrder(cartId: String)
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
        case let .rewardDetail(code):
            return "rewards/\(code).json"
        case let .redeemRewards(code):
            return "rewards/\(code)/redeem.json"
        case .redeemHistory:
            return "redeemed_rewards.json"
        case .products:
            return "products.json"
        case let .productDetail(code):
            return "products/\(code).json"
        case let .orders:
            return "orders.json"
        case let .orderDetail(orderId):
            return "orders/\(orderId).json"
        case let .submitOrder(cartId):
            return "orders/\(cartId)/submit.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getToken, .submitOrder:
            return .post
        case .redeemRewards:
            return .patch
        case .rewards, .rewardDetail, .redeemHistory, .products, .productDetail, .orders, .orderDetail:
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
