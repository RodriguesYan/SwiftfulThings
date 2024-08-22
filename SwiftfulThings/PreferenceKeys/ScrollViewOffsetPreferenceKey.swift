//
//  ScrollViewOffsetPreferenceKey.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 31/07/24.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey2: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey2.self, value: geo.frame(in: .global).minY)
                    
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey2.self, perform: { value in
                action(value)
            })
    }
}

struct ScrollViewOffsetPreferenceKey: View {
    let title: String = "NEw title here!!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 63.0)
                    .onScrollViewOffsetChange { offset in
                        self.scrollViewOffset = offset
                    }
                contentLayer
            }.padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        .overlay(
            navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0.0),
            alignment: .top
        )
    }
}

#Preview {
    ScrollViewOffsetPreferenceKey()
}

extension ScrollViewOffsetPreferenceKey {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<100) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}
