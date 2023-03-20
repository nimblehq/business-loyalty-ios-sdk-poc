//
//  NimbleLoyaltySDK.swift
//  NimbleLoyaltySDK
//
//  Created by David Bui on 16/03/2023.
//

import Foundation

public final class NimbleLoyaltySDK {

    public static let shared = NimbleLoyaltySDK()

    private(set) var clientId: String = ""

    private init() {}

    public func setClientId(_ clientId: String) {
        guard !clientId.isEmpty else {
            fatalError("Client Id must not be empty")
        }
        self.clientId = clientId
    }
}
