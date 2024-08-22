//
//  ViewBuilder.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 29/07/24.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            if let icon = iconName {
                Image(systemName: icon)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content:View>: View {
    let title: String
    var content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content:View>:View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "New title", description: "Hello", iconName: "heart.fill")
            HeaderViewRegular(title: "AnotherTitle", description: nil, iconName: nil)
            
            HeaderViewGeneric(title: "Generic 2") {
                HStack {
                    Text("hi")
                    Text("hi")
                    Image(systemName: "heart.fill")
                    Text("hi")
                }
            }
            CustomHStack {
                Text("hi")
                Text("hi")
            }
            HStack {
                Text("Hii")
                Text("Hii")
            }
            Spacer()
        }
        
    }
}

#Preview {
//    ViewBuilderBootcamp()
    LocalViewBuilder(type: .two)
}

struct LocalViewBuilder: View {
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("Twoo")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}
