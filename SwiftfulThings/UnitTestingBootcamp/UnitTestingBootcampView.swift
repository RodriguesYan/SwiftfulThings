//
//  UnitTestingBootcampView.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 24/09/24.
//

import SwiftUI

struct UnitTestingBootcampView: View {
    @StateObject private var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(
            wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium)
        )
    }
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcampView(
        isPremium: true
    )
}
