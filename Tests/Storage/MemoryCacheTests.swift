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
            storage.pairs.count,
            1
        )
        
        XCTAssertNil(
            storage.pairs.first { $0.key == 0 }
        )
        
        XCTAssertNil(
            storage.pairs.first { $0.key == 1 }
        )
        
        let pair = storage.pairs.first { $0.key == 2 }
        
        XCTAssertEqual(
            pair?.key,
            2
        )
        
        XCTAssertEqual(
            pair?.value,
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
            
            XCTAssert(
                indices?.contains(2) == true
            )
            
        }
        
        subscriptions.append(subscription)
        
        storage.setPairs(
            AnyCollection(
                [
                    (key: 0, value: "Hello"),
                    (key: 2, value: "World")
                ]
            )
        )
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
