//
//  Constants+API.swift
//  LoyaltySDK
//
//  Created by David Bui on 17/03/2023.
//

import Foundation

extension Constants.API {

    static var baseUrl: String { "https://cx-web.herokuapp.com/" }
    static var authUrl: String { "https://cx-web.herokuapp.com/oauth/authorize" }
    static var redirectUri: String { "nimble-cx://oauth/callback" }
    static var responseType: String { "code" }
    static var scope: String { "read" }

    static func makeAuthRequestUrl(clientId: String) -> String {
        "\(Self.authUrl)?client_id=\(clientId)&redirect_uri=\(Self.redirectUri)&response_type=\(Self.responseType)&scope=\(Self.scope)"
    }
}
