//
//  Generics.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 18/07/24.
//

import SwiftUI

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    @Published var genericStringModel = GenericModel(info: "Hello world")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T:View>: View {
    let title: String
    let content: T
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
        
    }
}

struct Generics: View {
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            GenericView(title: "bleee", content: Text("blaaaa"))
//            GenericView(title: "Hi there")
            
//            Text(vm.genericStringModel.info ?? "no data")
//            Text(vm.genericBoolModel.info?.description ?? "false")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    Generics()
}
