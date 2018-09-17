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
        
        let cache = MemoryCache<Int, String>()
        
        let storage = AnyStorage(cache)
        
        XCTAssert(storage.pairs.isEmpty)
        
        storage.setPairs(
            AnyCollection(
                [
                    (key: 2, value: "Hello")
                ]
            )
        )
        
        XCTAssertEqual(
            storage.count,
            1
        )
        
        XCTAssertNil(
            storage[0]
        )
        
        XCTAssertNil(
            storage[1]
        )
        
        XCTAssertEqual(
            storage[2],
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
