//
//  talabyehTests.swift
//  talabyehTests
//
//  Created by loai elayan on 10/4/20.
//  Copyright © 2020 Dominate. All rights reserved.
//

import XCTest
@testable import Moya
@testable import talabyeh

class talabyehTests: XCTestCase {
    
    
    func testUserTypesAPI(){
        let provider: MoyaProvider<GeneralAPI> = .default()
        
        
        let expectation = XCTestExpectation(description: "Testing the User Types API..")
        provider.request(.userTypes) { (result) in
            switch result {
            case .success(let response):

                do {
                    let mappedType = try response.map(ResponseContainer<[APIUserType]>.self)
                    if mappedType.status.code != 200 {
                        XCTFail("Faild for API Error: \(mappedType.status.message)")
                    }

                    expectation.fulfill()
                } catch {
                    XCTFail("Faild for decoding: \(error.localizedDescription)")
                }
                
                break
            case .failure(let error):
                XCTFail("MoyaError: \(error.localizedDescription)")
                break
            }
        }
        
        
        // We ask the unit test to wait our expectation to finish.
        self.wait(for: [expectation], timeout: 10)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
