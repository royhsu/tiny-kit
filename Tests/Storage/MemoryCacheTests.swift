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
        
        XCTAssertEqual(
            cache.count,
            0
        )
        
        cache.setValue(
            "Hello",
            forKey: 0
        )
        
        XCTAssertEqual(
            cache.count,
            1
        )
        
        XCTAssertEqual(
            cache.value(forKey: 0),
            "Hello"
        )
        
    }
    
    internal final func testSubscribeIndexDiff() {
        
        let promise = expectation(description: "Should get notified about indices changes.")
        
        let cache = MemoryCache<Int, String>()
        
        subscriptions.append(
            cache.keyDiff.subscribe { event in
                
                promise.fulfill()
                
                let indices = event.currentValue
                
                XCTAssert(
                    indices?.contains(1) == true
                )
                
                XCTAssert(
                    indices?.contains(3) == true
                )
                
            }
        )
        
        cache.setKeyValuePairs(
            [
                1: "Hello",
                3: "World"
            ]
        )
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }

}
