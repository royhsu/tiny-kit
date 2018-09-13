//
//  AnyStorageTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnyStorageTests

import TinyCore
import XCTest

@testable import TinyKit

internal final class AnyStorageTests: XCTestCase {
    
    internal final var subscriptions: [ObservableSubscription] = []
    
    internal final func testGetter() {
        
        let cache = MemoryCache<Int, String>()
        
        let storage = AnyStorage(cache)
        
        XCTAssertNil(storage.maxKey)
        
        cache[2] = "Hello"
        
        XCTAssertEqual(
            storage.maxKey,
            2
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
        
        let storage = AnyStorage(cache)
        
        let subscription = storage.keyDiff.subscribe { event in
            
            promise.fulfill()
            
            let indices = event.currentValue
            
            XCTAssert(
                indices?.contains(0) == true
            )
            
        }
        
        subscriptions.append(subscription)
        
        cache[0] = "Hello"
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
