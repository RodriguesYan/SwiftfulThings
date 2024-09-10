//
//  AppTabbarView.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 22/08/24.
//

import SwiftUI

extension Collection {
    var second: Element? { dropFirst().first }
}

struct AppTabbarView: View {
    @State private var selection: String = "home"
    @State private var tabSelection: TabbarItem = TabDummy.tabs.first!
    
    var body: some View {
        CustomTabbarContainerView(selection: $tabSelection) {
            Color.blue
                .tabbarItem(tab: TabDummy.tabs.first!, selection: $tabSelection)
            
            Color.red
                .tabbarItem(tab: TabDummy.tabs[1], selection: $tabSelection)
            
            Color.green
                .tabbarItem(tab: TabDummy.tabs[2], selection: $tabSelection)
        }
    }
}

#Preview {
    AppTabbarView()
}

extension AppTabbarView {
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
