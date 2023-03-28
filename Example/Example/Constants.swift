//
//  Constants.swift
//  Example
//
//  Created by David Bui on 22/03/2023.
//

import ExampleKeys
import SwiftUI

enum Constants {

    enum App {}
    enum Color {}
}

extension Constants.App {

    static let clientId: String = ExampleKeys.Keys.Debug().clientId
    static let clientSecret: String = ExampleKeys.Keys.Debug().clientSecret
}

extension Constants.Color {

    static let mirageBlack = Color(hex: "#1A202C")
    static let slateGray = Color(hex: "#718096")
    static let havelockBlue = Color(hex: "#5A67D8")
    static let catskillWhite = Color(hex: "#EDF2F7")
    static let chateauGreen = Color(hex: "#38A169")
}
