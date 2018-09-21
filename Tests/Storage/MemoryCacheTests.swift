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
    
    // Done.
    internal final func testInitialize() {
        
        let cache = MemoryCache<Int, String>()
        
        XCTAssert(cache.isEmpty)
        
    }
    
    // Done.
    internal final func testLoad() {
        
        let promise = expectation(description: "Load the cache.")
        
        let cache = MemoryCache<Int, String>()
        
        XCTAssertFalse(cache.isLoaded)
        
        cache.load { result in
            
            promise.fulfill()
            
            switch result {
                
            case .success:
            
                XCTAssert(cache.isLoaded)
                
                XCTAssert(cache.isEmpty)
                
            case let .failure(error): XCTFail("\(error)")
            
            }
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
    // Done.
    internal final func testSetValue() {
        
        let promise = expectation(description: "Get notified about changes.")
        
        var cache = MemoryCache<Int, String>()

        subscriptions.append(
            cache.changes.subscribe { event in
                
                promise.fulfill()
                
                let changes = event.currentValue
                
                XCTAssertEqual(
                    changes?.count,
                    1
                )
                
                let valueChange = changes?.first { $0.key == 2 }
                
                XCTAssert(valueChange != nil)
                
            }
        )
        
        cache[2] = "Hello"
        
        XCTAssertEqual(
            cache.count,
            1
        )
        
        XCTAssert(
            cache[0] == nil
        )
        
        XCTAssert(
            cache[1] == nil
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
    
    internal final func testMergeValues() {
        
        let promise = expectation(description: "Get notified about changes.")
        
        var cache: MemoryCache = [
            "existing": "value",
            "replacing": "current value"
        ]
        
        let changes = cache.changes
        
        let subscription = cache.changes.subscribe { event in

            promise.fulfill()
            
            let changes = event.currentValue
            
            XCTAssertEqual(
                changes?.count,
                2
            )
            
            let existingValueChange = changes?.first { $0.key == "existing" }
            
            XCTAssert(existingValueChange == nil)
            
            let newValueChange = changes?.first { $0.key == "new" }
            
            XCTAssert(newValueChange != nil)
            
            XCTAssertEqual(
                newValueChange?.value,
                "value"
            )
            
            let replaceValueChange = changes?.first { $0.key == "replacing" }
            
            XCTAssert(replaceValueChange != nil)
            
            XCTAssertEqual(
                replaceValueChange?.value,
                "by value"
            )
            
            let nilValueChange = changes?.first { $0.key == "nil" }
            
            XCTAssert(nilValueChange == nil)
            
        }
        
        subscriptions.append(subscription)
        
        let newElements: [ (String, String?) ] =  [
            ("new", "value"),
            ("replacing", "by value"),
            ("nil", nil)
        ]
        
        cache.merge(
            AnySequence(newElements)
        )
        
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
        
        XCTAssert(
            cache["nil"] == nil
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
    
    // Discard.
    internal final func testGetValueAsynchronously() {
        
        let promise = expectation(description: "Get value asynchronously.")
        
        let cache: MemoryCache = [
            0: "Hello"
        ]
        
        cache.value(forKey: 0) { result in
            
            promise.fulfill()
            
            switch result {
                
            case let .success(value):
                
                XCTAssertEqual(
                    value,
                    "Hello"
                )
                
            case let .failure(error): XCTFail("\(error)")
                
            }
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
    internal final func testRemoveAll() {
        
        let promise = expectation(description: "Remove all values.")
        
        let cache: MemoryCache = [
            "delete": "value"
        ]
        
        subscriptions.append(
            cache.changes.subscribe { event in
                
                promise.fulfill()
                
                XCTAssert(cache.isEmpty)
                
                let changes = event.currentValue
                
                let removeValueChange = changes?.first { $0.key == "delete" }
                
                XCTAssert(removeValueChange != nil)
                
            }
        )
        
        cache.removeAll()
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
