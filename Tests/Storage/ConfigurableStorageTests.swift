//
//  ConfigurableStorageTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/19.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ConfigurableStorageTests

import XCTest

@testable import TinyKit

internal final class ConfigurableStorageTests: XCTestCase {

    internal final func testInitialize() {

        let storage = ConfigurableStorage<String, String>()

        XCTAssert(storage.isEmpty)

    }
    
    internal final func test() {
        
        let promise = expectation(description: "Get value from the callback.")
        
        var storage = ConfigurableStorage<String, String>()
        
        storage.registerStorage(MemoryCache.self)
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }

}
