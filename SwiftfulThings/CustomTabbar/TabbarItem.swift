//
//  TabbarItem.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 29/08/24.
//

import Foundation
import SwiftUI

//struct TabbarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabbarItem: Hashable {
    case home, favorites, profile
    
    var iconName: String {
        switch self {
            case .home: return "house"
            case .favorites: return "heart"
            case .profile: return "person"
        }
    }
    
    var title: String {
        switch self {
            case .home: return "Home"
            case .favorites: return "Favorites"
            case .profile: return "Profile"
        }
    }
    
    var color: Color {
        switch self {
            case .home: return Color.red
            case .favorites: return Color.blue
            case .profile: return Color.green
        }
    }
}
