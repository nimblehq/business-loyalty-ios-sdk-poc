//
//  AuthenticationRepositoryProtocol.swift
//  NimbleLoyalty
//
//  Created by David Bui on 21/03/2023.
//

import Foundation

protocol AuthenticationRepositoryProtocol: AnyObject {

    func getToken(authToken: String, _ completion: @escaping RequestCompletion<APIToken>)
}
