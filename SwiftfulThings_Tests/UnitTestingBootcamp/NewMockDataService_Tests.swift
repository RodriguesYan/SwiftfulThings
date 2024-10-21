//
//  NewMockDataService_Tests.swift
//  SwiftfulThings_Tests
//
//  Created by Yan Rodrigues on 27/09/24.
//

import XCTest
@testable import SwiftfulThings
import Combine

final class NewMockDataService_Tests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        cancellables.removeAll()
    }
    
    func test_NewMOckDataService_init_doesSetValuesCorrectly() {
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        let dataService = NewMockDataService(items:  items)
        let dataService2 = NewMockDataService(items:  items2)
        let dataService3 = NewMockDataService(items:  items3)
        
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMOckDataService_downloadItemsWithEscaping_doesReturnValues() {
        let dataService = NewMockDataService(items:  nil)
        let expectation = XCTestExpectation()
        var items: [String] = []
        
        dataService.downloadItemsWithEscaping { returneditems in
            items = returneditems
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
        
    }
    
    func test_NewMOckDataService_downloadItemsWithCombine_doesReturnValues() {
        let dataService = NewMockDataService(items:  nil)
        let expectation = XCTestExpectation()
        var items: [String] = []
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
        
    }
    
    func test_NewMOckDataService_downloadItemsWithCombine_doesFail() {
        let dataService = NewMockDataService(items:  [])
        let expectation = XCTestExpectation(description: "Does throw an error")
        var items: [String] = []
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServiceResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellables)

        
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
        
        
    }

}
