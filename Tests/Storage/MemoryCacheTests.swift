//
//  MemoryCacheTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MemoryCacheTests

import TinyCore
import XCTest

@testable import TinyKit

internal final class MemoryCacheTests: XCTestCase {

    internal final var subscriptions: [ObservableSubscription] = []
    
    internal final func testSetterAndGetter() {
        
        let cache = MemoryCache<Int, String>()
        
        XCTAssertNil(cache.maxKey)
        
        cache[2] = "Hello"
        
        XCTAssertEqual(
            cache.maxKey,
            2
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
    
    internal final func testSubscribeKeyDiffBySubscriptSetter() {
        
        let promise = expectation(description: "Should get notified about indices changes.")
        
        let cache = MemoryCache<Int, String>()
        
        let subscription = cache.keyDiff.subscribe { event in
            
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
    
    internal final func testSubscribeKeyDiffByKeyValuePairsSetter() {
        
        let promise = expectation(description: "Should get notified about indices changes.")
        
        let cache = MemoryCache<Int, String>()
        
        let subscription = cache.keyDiff.subscribe { event in
            
            promise.fulfill()
            
            let indices = event.currentValue
            
            XCTAssert(
                indices?.contains(0) == true
            )
            
            XCTAssert(
                indices?.contains(2) == true
            )
            
        }
        
        subscriptions.append(subscription)
        
        cache.setKeyValuePairs(
            [
                0: "Hello",
                2: "World"
            ]
        )
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }

}
