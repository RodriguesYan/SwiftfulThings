//
//  CustomTabbarContainerView.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 27/08/24.
//

import SwiftUI

struct CustomTabbarContainerView<Content: View>: View {
    let content: Content
    @Binding var selection: TabbarItem
    @State private var tabs: [TabbarItem] = [
    ]
    
    init(selection: Binding<TabbarItem>, @ViewBuilder content: () -> Content ) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            CustomTabbarView(tabs: tabs, selection: $selection, localSelection: selection)
        }

        .onPreferenceChange(TabbarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

#Preview {
    CustomTabbarContainerView(
        selection: .constant(TabDummy.tabs.first!)) {
            Color.red
        }
}
