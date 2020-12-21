//
//  CurrencySceneTests.swift
//  challengeTaskTests
//
//  Created by Mahmoud Abdelshafi on 12/21/20.
//

import XCTest
@testable import challengeTask

class CurrencySceneTests: XCTestCase {
    
    var viewModel: CurrencyViewModel!
    var currencyRepo: CurrencyMockRepo!
    
    override func setUpWithError() throws {
        currencyRepo = CurrencyMockRepo()
        viewModel = CurrencyViewModel(currencyRepo: currencyRepo)
    }

    override func tearDownWithError() throws {
        currencyRepo = nil
        viewModel = nil
    }

    func testGetCurrencyRatesResponse() throws {
        // given
        currencyRepo.shouldSuccess = true
        let response = [Currency]()
        currencyRepo.getCurrencyResponse = Currency(success: true, timestamp: 0, base: "", date: "", rates: response.first?.rates)
        // When
        viewModel.getCurrencyRates()
        //Then
        var responseCount = 1
        viewModel.currencyRatesResponse.bind { (value) in
            responseCount = value.values.count
        }
        XCTAssertNotEqual(responseCount, 0)
      
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
