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
    var imageName: String?
    var height: CGFloat = 32.0
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxHeight: .infinity, alignment: .center)
                } else {
                    HStack(spacing: 10.0) {
                        if let imageName {
                            Image(systemName: imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .frame(width: 20.0, height: 20.0)
                        }
                        Text(title)
                            .font(.system(size: 14.0))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8.0)
                    }
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
