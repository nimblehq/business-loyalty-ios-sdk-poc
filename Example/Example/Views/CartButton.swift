//
//  CartButton.swift
//  Example
//
//  Created by Edgars Simanovskis on 20/4/23.
//

import SwiftUI

struct CartButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "cart")
                .foregroundColor(Constants.Color.havelockBlue)
        }
    }
}

//struct CartButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CartButton()
//    }
//}
