//
//  PreferenceKeyPage.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 31/07/24.
//

import SwiftUI

struct PreferenceKeyPage: View {
    @State private var text: String = "Hello world"
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text:text)
                    .navigationTitle("Navigation Title")
            }
            
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct SecondaryScreen: View {
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear(perform: getDataFromDatabase)
            .customTitle(newValue)
    }
    
    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE FROM DATABASEE"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

#Preview {
    PreferenceKeyPage()
}
