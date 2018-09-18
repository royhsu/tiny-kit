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
    
    internal final func testGetterAndSetter() {
        
        var cache = NewMemoryCache<Int, String>()
    
        XCTAssert(cache.isEmpty)
        
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
        
    }
    
    internal final func testSubscribeKeyDiff() {
        
        let promise = expectation(description: "Should get notified about indices changes.")
        
        let cache = MemoryCache<Int, String>()
        
        var storage = AnyStorage(cache)
        
        storage[3] = "Existing value"
        
        let subscription = storage.keyDiff.subscribe { event in
            
            promise.fulfill()
            
            let indices = event.currentValue
            
            XCTAssert(
                indices?.contains(0) == true
            )
            
            // There is not existing value for key 2. Should not be included in changed indices.
            XCTAssert(
                indices?.contains(2) == false
            )
            
            // There is an existing value for key 3.
            XCTAssert(
                indices?.contains(3) == true
            )
            
        }
        
        subscriptions.append(subscription)
        
        let pairs: [(key: Int, value: String?)] = [
            (0, "Hello"),
            (2, nil),
            (3, nil)
        ]
        
        storage.setPairs(
            AnyCollection(pairs)
        )
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
