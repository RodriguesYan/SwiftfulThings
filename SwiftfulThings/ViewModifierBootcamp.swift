//
//  ViewModifier.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 04/07/24.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    func withDefaultButtonFOrmatting(color: Color = .red) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: color))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello world!")
                .withDefaultButtonFOrmatting(color: Color.blue)
            
            Text("Hello world!")
                .withDefaultButtonFOrmatting()
        }.padding()
    }
}

#Preview {
    ViewModifierBootcamp()
}
