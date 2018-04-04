//
//  RecollectionTests.swift
//  RemindMeTests
//
//  Created by Raghu, Reshma L on 4/4/18.
//  Copyright © 2018 Raghu, Reshma L. All rights reserved.
//

import XCTest
@testable import RemindMe

class RecollectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetRecollection() {
		let memories = MemoryBankManager.shared.recollectMemories(for: "J.P.Nagar")
		if memories.count > 0 {
			assert(memories[0].task == "Visit crosswords")
		}
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
