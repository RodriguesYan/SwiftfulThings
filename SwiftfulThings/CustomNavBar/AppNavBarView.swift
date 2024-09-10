//
//  CustomNavigatorBar.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 02/09/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(
                    destination: Text("Destination")
                        .customNavigationTitle("Second screen")
                        .customNavigationSubTitle("Subtitle showing")
                ) {
                    Text("Navigate")
                }
            }
            .customNavBarItems(
                title: "NewTitle",
                subtitle: "Subtitle",
                backbuttonHidden: true
            )
        }
    }
}

#Preview {
    AppNavBarView()
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()
                
                NavigationLink(
                    destination: Text("Destination")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false),
                    
                    label: {
                        Text("Navigate")
                    }
                
                )
            }
            .navigationTitle("Nav title here")
        }
    }
}
