//
//  CustomButtonStyles.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 08/07/24.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
//            .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        self.buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct CustomButtonStyles: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("CLick me")
                .font(.headline)
                .withDefaultButtonFOrmatting()
        })
//        .buttonStyle(PressableButtonStyle())
        .withPressableStyle()
        .padding(40)

    }
}

#Preview {
    CustomButtonStyles()
}
