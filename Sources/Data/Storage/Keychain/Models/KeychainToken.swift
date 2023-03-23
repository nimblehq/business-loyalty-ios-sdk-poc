//
//  KeychainToken.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//

import Foundation

struct KeychainToken: Token, Codable {

    let accessToken: String?
    let tokenType: String
    let expiresIn: Int
    let createdAt: Int

    init(_ token: Token) {
        accessToken = token.accessToken
        tokenType = token.tokenType
        expiresIn = token.expiresIn
        createdAt = token.createdAt
    }
}
