//
//  Constants+API.swift
//  LoyaltySDK
//
//  Created by David Bui on 17/03/2023.
//

import Foundation

extension Constants.API {

    static let baseUrl: String = "https://cx-web.herokuapp.com/"
    static let authUrl: String = "https://cx-web.herokuapp.com/oauth/authorize"
    static let redirectURI: String = "nimble-cx://oauth/callback"
    static let responseType: String = "code"
    static let scope: String = "read"

    static func makeAuthRequestUrl(clientId: String) -> String {
        "\(Self.authUrl)?client_id=\(clientId)&redirect_uri=\(Self.redirectURI)&response_type=\(Self.responseType)&scope=\(Self.scope)"
    }
}
