//
//  NavigationBackButtonModifier.swift
//  Example
//
//  Created by David Bui on 27/03/2023.
//

import Foundation

import SwiftUI

struct NavigationBackButtonModifier: ViewModifier {

    var action: () -> Void

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: action) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Constants.Color.mirageBlack)
                    .frame(width: 44.0, height: 44.0)
                    .aspectRatio(1.0, contentMode: .fit)
                    .padding(.leading, 5.0)
            })
    }
}
