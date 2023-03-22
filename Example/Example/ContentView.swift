//
//  ContentView.swift
//  Example
//
//  Created by David Bui on 20/03/2023.
//

import NimbleLoyalty
import SwiftUI
import UIKit

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
            NimbleLoyalty.shared.setClientId(Constants.clientId)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {               
                NimbleLoyalty.shared.authenticate { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }
        }
    }
}
