//
//  Token.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//


import Foundation

protocol Token {

    var accessToken: String? { get }
    var tokenType: String { get }
    var expiresIn: Int { get }
    var createdAt: Int { get }
}
