//
//  CustomNavBarContainerView.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 02/09/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0, content: {
            CustomNavBarView(
                showBackButton: showBackButton,
                title: title,
                subtitle: subtitle
            )
            content
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            Spacer()
        })
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self , perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarSubTitlePreferenceKey.self , perform: { value in
            self.subtitle = value
        })
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self , perform: { value in
            self.showBackButton = !value
        })
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("Hello, world")
                .foregroundColor(.white)
        }
    }
}
