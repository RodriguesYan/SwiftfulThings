//
//  UnitTestingBootcampViewModel_Tests.swift
//  SwiftfulThings_Tests
//
//  Created by Yan Rodrigues on 24/09/24.
//

import XCTest
@testable import SwiftfulThings
import Combine

final class UnitTestingBootcampViewModel_Tests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UnitTetingBootcampViewModel_isPremium_shouldBeTrue() {
        let isPremium: Bool = true
        
        let vm = UnitTestingBootcampViewModel(
            isPremium: isPremium
        )
        
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTetingBootcampViewModel_isPremium_shouldBeFalse() {
        let isPremium: Bool = false
        
        let vm = UnitTestingBootcampViewModel(
            isPremium: isPremium
        )
        
        XCTAssertFalse(vm.isPremium)
    }
    
    
    func test_UnitTetingBootcampViewModel_isPremium_shouldInjectValue() {
        let isPremium: Bool = Bool.random()
        
        let vm = UnitTestingBootcampViewModel(
            isPremium: isPremium
        )
        
        XCTAssertEqual(vm.isPremium, isPremium)
    }
    
    func test_UnitTetingBootcampViewModel_isPremium_shouldInjectValue_stress() {
        for _ in 0..<10 {
            let isPremium: Bool = Bool.random()
            
            let vm = UnitTestingBootcampViewModel(
                isPremium: isPremium
            )
            
            XCTAssertEqual(vm.isPremium, isPremium)
        }
    }
    
    func test_UnitTestingBootcampViewMOdel_dataArray_shouldBeEmpty() {
        let vm = UnitTestingBootcampViewModel(
            isPremium: true
        )
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewMOdel_dataArray_shouldAddItem() {
        let vm = UnitTestingBootcampViewModel(
            isPremium: true
        )
        
        vm.addItem(item: "MyItem")
        
        XCTAssertTrue(vm.dataArray.count > 0)
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray[0] , "MyItem")
        //XTAssertLessThan
        //XCTFail
    }
    
    func test_UnitTestingBootcampViewMOdel_downloadWithEscaping_shouldReturnItems() {
        let vm = UnitTestingBootcampViewModel(
            isPremium: Bool.random()
        )
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewMOdel_downloadWithCombine_shouldReturnItems() {
        let vm = UnitTestingBootcampViewModel(
            isPremium: Bool.random()
        )
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
}
