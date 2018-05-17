//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by B.N Vinay on 5/8/18.
//  Copyright © 2018 ripl. All rights reserved.
//

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {
    let viewcontroller:ViewController = ViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(2, 2, "Score computed from guess is rite")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
