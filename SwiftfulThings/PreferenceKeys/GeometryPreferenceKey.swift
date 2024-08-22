//
//  GeometryPreferenceKey.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 31/07/24.
//

import SwiftUI

struct GeometryPreferenceKey: View {
    @State private var rectSize: CGSize = .zero
    var body: some View {
        VStack {
            Spacer()
            Text("Hello world!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                GeometryReader(content: { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                })
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectanglePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectanglePreferenceKey.self, value: size)
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    GeometryPreferenceKey()
}
