//
//  Typealiases.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import UIKit

typealias HTTPHeaders = [String: String]
public typealias RequestCompletion<T> = (Result<T, NimbleLoyaltyError>) -> Void
