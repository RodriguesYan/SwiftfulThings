//
//  CustomTransition.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 10/07/24.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    
    static var rotating: AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static func rotating(amount: Double) -> AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: amount),
            identity: RotateViewModifier(rotation: 0)
        )
    }
    
    static var rotateOn: AnyTransition {
        asymmetric(insertion: .rotating, removal: .move(edge: .leading))
    }
}

struct CustomTransition: View {
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height:350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(.move(edge: .leading))
//                    .transition(AnyTransition.scale.animation(.easeInOut))
//                    .transition(AnyTransition.rotating.animation(.easeInOut))
//                    .transition(.rotating(amount: 1080))
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Click me")
                .withDefaultButtonFOrmatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

#Preview {
    CustomTransition()
}
