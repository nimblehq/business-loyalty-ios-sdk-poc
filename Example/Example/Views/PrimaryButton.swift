//
//  PrimaryButton.swift
//  Example
//
//  Created by David Bui on 24/03/2023.
//

import SwiftUI

struct PrimaryButton: View {
    
    @Binding var isEnabled: Bool
    
    let titleColor: Color = .white
    let backgroundColor: Color = Constants.Color.havelockBlue
    let isLoading: Bool
    
    var action: () -> Void
    var title: String
    var height: CGFloat = 32.0
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    Text(title)
                        .font(.system(size: 14.0))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8.0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: height)
            .background(Constants.Color.havelockBlue)
            .cornerRadius(4.0)
            .background(isEnabled ? backgroundColor : backgroundColor.opacity(0.5))
            .disabled(isLoading || !isEnabled)
            .cornerRadius(4.0)
            Spacer()
        }
    }
}
