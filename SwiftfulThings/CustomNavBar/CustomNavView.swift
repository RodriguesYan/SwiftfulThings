//
//  CustomNavView.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 02/09/24.
//

import SwiftUI

struct CustomNavView<Content:View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    CustomNavView {
        Color.red.ignoresSafeArea()
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = nil
    }
}
