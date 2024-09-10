//
//  CustomTabbarView.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 22/08/24.
//

import SwiftUI

struct CustomTabbarView: View {
    let tabs: [TabbarItem]
    @Binding var selection: TabbarItem
    @Namespace private var namespace
    @State var localSelection: TabbarItem
    
    var body: some View {
        tabbarVersion2
            .onChange(of: selection) { oldValue, newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

extension CustomTabbarView {
    private func tabView(tab: TabbarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.headline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(localSelection == tab ? tab.color.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
    
    private func switchToTab(tab: TabbarItem) {
        selection = tab
    }
    
    private var tabbarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
    }
}

class TabDummy {
    static let tabs: [TabbarItem] = [
        .home,
        .favorites,
        .profile,
    ]
}


#Preview {
    VStack {
        Spacer()
        
        CustomTabbarView(
            tabs: TabDummy.tabs, selection: .constant(TabDummy.tabs.first!), localSelection: TabDummy.tabs.first!
        )
    }
}

extension CustomTabbarView {
    private func tabView2(tab: TabbarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.headline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var tabbarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
