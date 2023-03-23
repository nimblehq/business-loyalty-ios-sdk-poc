//
//  APIToken.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//

import Foundation

struct APIToken: Token, Decodable, Equatable {

    let accessToken: String?
    let tokenType: String
    let expiresIn: Int
    let createdAt: Int
}
