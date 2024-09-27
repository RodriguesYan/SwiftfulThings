//
//  DependencyInjectionBootcamp.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 18/09/24.
//

import SwiftUI
import Combine

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class MockDataService: DataServiceProtocol {
    let testData: [PostsModel] = [
        PostsModel(userId: 1, id: 1, title: "One", body: "One"),
        PostsModel(userId: 1, id: 1, title: "Two", body: "Two")
    ]
    
    //A way to mock AnyPublisher responses
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap({ $0})
            .eraseToAnyPublisher()
    }
}

class ProductionDataService {
    let url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class DependencyInjectionViewModel: ObservableObject {
    let dataService: ProductionDataService
    
    init(dataService: ProductionDataService) {
        self.dataService = dataService
        loadPosts()
    }
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnPosts in
                self?.dataArray = returnPosts
            }
            .store(in: &cancellables)

    }
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: ProductionDataService) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    DependencyInjectionBootcamp(
        dataService: ProductionDataService()
    )
}
