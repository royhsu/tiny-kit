//
//  StorageReducerTests.swift
//  TinyKitTest
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StorageReducerTests

import TinyStorage
import XCTest

@testable import TinyKit

internal final class StorageReducerTests: XCTestCase {
    
    internal final func testReduce() {
        
        let promise = expectation(description: "Reduce the storage.")
        
        let cache: MemoryCache = [
            0: "hello",
            1: "world"
        ]
        
        let reducer = StorageReducer(
            storage: cache,
            reduction: { storage in
                
                return Set(
                    storage.elements.map { $0.value }
                )
                
            }
        )
        
        reducer.reduce { result in
            
            defer { promise.fulfill() }
            
            switch result {
                
            case let .success(value):
                
                XCTAssertEqual(
                    value,
                    Set(
                        [
                            "hello",
                            "world"
                        ]
                    )
                )
                
            case let .failure(error): XCTFail("\(error)")
                
            }
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
