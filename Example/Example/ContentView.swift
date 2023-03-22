//
//  ContentView.swift
//  Example
//
//  Created by David Bui on 20/03/2023.
//

import NimbleLoyalty
import SwiftUI
import UIKit
import WebKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello Nimble!")
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                NimbleLoyalty.shared.setClientId("MRC6bwFASOm0sJYPYwVEt2KD51bkAtdgS7ltqeDYUf4")
                NimbleLoyalty.shared.signIn()
            }
        }
    }
}
