//
//  MemoryCacheTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnyStorageTests

import TinyCore
import XCTest

@testable import TinyKit

internal final class MemoryCacheTests: XCTestCase {
    
    internal final var subscriptions: [ObservableSubscription] = []
    
    internal final func testInitialize() {
        
        let cache = NewMemoryCache<Int, String>()
        
        XCTAssert(cache.isEmpty)
        
    }
    
    internal final func testMutateSingleKeyAndValue() {
        
        let promise = expectation(description: "Get notified about changes.")
        
        var cache = NewMemoryCache<Int, String>()

        subscriptions.append(
            cache.changes.subscribe { event in
                
                promise.fulfill()
                
                let changes = event.currentValue
                
                XCTAssertEqual(
                    changes?.count,
                    1
                )
                
                let valueChange = changes?.first { $0.key == 2 }
                
                XCTAssertNotNil(valueChange)
                
            }
        )
        
        cache[2] = "Hello"
        
        XCTAssertEqual(
            cache.count,
            1
        )
        
        XCTAssertNil(
            cache[0]
        )
        
        XCTAssertNil(
            cache[1]
        )
        
        XCTAssertEqual(
            cache[2],
            "Hello"
        )
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
    internal final func testMutateMultipleKeysAndValues() {
        
        let promise = expectation(description: "Get notified about changes.")
        
        var cache: NewMemoryCache = [
            "existing": "value",
            "replacing": "current value"
        ]
        
        let changes = cache.changes
        
        let subscription = cache.changes.subscribe { event in

            promise.fulfill()

            let changes = event.currentValue
            
            let existingValueChange = changes?.first { $0.key == "existing" }
            
            XCTAssertNil(existingValueChange)
            
            let newValueChange = changes?.first { $0.key == "new" }
            
            let replaceValueChange = changes?.first { $0.key == "replacing" }
            
            XCTAssertNotNil(replaceValueChange)
            
            XCTAssertNotNil(newValueChange)
            
            let nilValueChange = changes?.first { $0.key == "nil" }
            
            XCTAssertNil(nilValueChange)
            
        }
        
        subscriptions.append(subscription)
        
        let newElements: [ (String, String?) ] =  [
            ("new", "value"),
            ("replacing", "by value"),
            ("nil", nil)
        ]
        
        cache.merge(newElements)
        
        XCTAssertEqual(
            cache["new"],
            "value"
        )
        
        XCTAssertEqual(
            cache["existing"],
            "value"
        )
    
        XCTAssertEqual(
            cache["replacing"],
            "by value"
        )
        
        XCTAssertNil(
            cache["nil"]
        )
        
        XCTAssertEqual(
            cache.count,
            3
        )
        
        let isObservableKept = (cache.changes === changes)
        
        XCTAssert(isObservableKept)
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }
    
}
