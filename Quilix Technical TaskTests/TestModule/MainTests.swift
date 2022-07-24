//
//  MainTest.swift
//  Quilix Technical TaskTests
//
//  Created by Евгений Агеенко on 24.07.22.
//

import XCTest
@testable import Quilix_Technical_Task

class MockManager: CoinManagerDelegate {
    var mockModel: [CoinModel]?
    var mockError: Error?
    
    func didUpdatePrice(model: [CoinModel]) {
        self.mockModel = model
    }
    
    func didFailWithError(error: Error) {
        self.mockError = error
    }
}

class MainTests: XCTestCase {
    
    var manager: MockManager!
    
    override func setUpWithError() throws {
        manager = MockManager()
        manager.mockModel = [CoinModel(name: "Baz", rate: 0.0)]
    }
    
    override func tearDownWithError() throws {
        manager = nil
    }
    
    
    func testCoinModel () {
        XCTAssertEqual(manager.mockModel?.first?.name, "Baz")
        XCTAssertEqual(manager.mockModel?.first?.rate, 0.0)
    }
    
    func testDetailViewController () {
        let model = CoinViewModel(currency: "", coinRate: 0)
        let detailViewController = DetailViewController(model: model)
        XCTAssertTrue(detailViewController is DetailViewController)
    }
    

}
