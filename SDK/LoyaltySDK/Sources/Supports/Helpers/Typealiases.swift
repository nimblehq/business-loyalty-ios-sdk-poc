//
//  Typealiases.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Combine
import UIKit

typealias CancelBag = Set<AnyCancellable>
typealias HTTPHeaders = [String: String]
/// Publisher with error `AnyPublisher<T, Error>`
typealias Observable<T> = AnyPublisher<T, Error>
/// Publisher with no error `AnyPublisher<T, Never>`
typealias Driver<T> = AnyPublisher<T, Never>
