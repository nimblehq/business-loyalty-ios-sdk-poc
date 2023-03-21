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
    static var redirectUri: String { "co.nimblehq.ios://oauth/callback" }

    static func makeAuthRequestUrl(clientId: String) -> String {
        "\(Constants.API.authUrl)?client_id=\(clientId)&redirect_uri=\(Constants.API.redirectUri)&response_type=code&scope=read"
    }
}
