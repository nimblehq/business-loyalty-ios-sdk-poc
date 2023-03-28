//
//  APIError.swift
//  LoyaltySDK
//
//  Created by David Bui on 21/03/2023.
//

import Foundation

struct APIError: Decodable, Error {

    var error: String?
}
