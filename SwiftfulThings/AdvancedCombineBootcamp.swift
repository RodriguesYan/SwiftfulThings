//
//  AdvancedCombineBootcamp.swift
//  SwiftfulThings
//
//  Created by Yan Rodrigues on 21/10/24.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    // @Published var basicPublisher: String = ""
    //Hold the current value
    //let currentValuePublishes = CurrentValueSubject<Int, Error>("First publish")
    // Just pass through values
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(0..<11)
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passThroughPublisher.send(items[x])
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)//Precisa passar um completion, caso queira pegar um "last value"
                }
                // self.basicPublisher = items[x]
            }
        }
        
    }
}

class AdvanceCombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataBool: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
//        dataService.passThroughPublisher
            //.first()
            //.first(where: {$0 > 4})
//            .tryFirst(where: { int in
//                if int == 3 {
//                    throw URLError(.badServerResponse)
//                }
//
//                return int > 4
//            })
            //.dropFirst(3)
            //.drop(while: { $0 < 5 })
            //.compactMap({ int in
                //if int == 5 {
                    //return nil
                //}
            //})
            //.removeDuplicate()
            //.replaceError()
            //.scan(0, { $0 + $1 })
            //.scan(0, +)
            //.reduce()
            //.collect()
            //.debounce()
            //.throttle
            //.combineLatest(dataService.boolPublisher, dataService.intPublisher)
        
        
//            .compactMap({ (int, bool) in
//                if bool {
//                    return String(int)
//                } else {
//                    return nil
//                }
//            })
//            .compactMap( {$1 ? String($0) : nil})
            //.removeDuplicates()
//            .compactMap({ (int1, bool, int2) in
//                if bool {
//                    return String(int1)
//                } else {
//                    return "n/a"
//                }
//            })
            //.merge()
            //.zip()
        
        let sharedPublisher = dataService.passThroughPublisher
            .share()
            .multicast {
                PassthroughSubject<Int,Error>()
            }//Tipo uma forma de fazer um lazy publisher
        
        sharedPublisher
            .map({ String($0)})
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)

        
        sharedPublisher
            .map({ $0 > 5 ? true : false})
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error)"
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBool.append(returnedValue)
            }
            .store(in: &cancellables)

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sharedPublisher.connect()
                .store(in: &self.cancellables)
        }

    }
}

struct AdvancedCombineBootcamp: View {
    @StateObject private var vm = AdvanceCombineBootcampViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.dataBool, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}
 
