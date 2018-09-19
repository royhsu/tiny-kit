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
    
    internal final func testGetValueFromSecondaryStorages() {
        
        let firstValuePromise = expectation(description: "Get the first value from the storage 1.")
        
        let secondValuePromise = expectation(description: "Get the second value from the storage 2.")
        
        let storage = ConfigurableStorage<String, String>()
        
        let storage1: MemoryCache = [
            "first": "first value from storage 1"
        ]
        
        let storage2: MemoryCache = [
            "first": "first value from storage 2",
            "second": "second value from storage 2"
        ]
        
        storage.registerStorage(storage1)
        
        storage.registerStorage(storage2)
        
        storage.value(forKey: "first") { result in
            
            firstValuePromise.fulfill()
            
            switch result {
                
            case let .success(value):
                
                XCTAssertEqual(
                    value,
                    "first value from storage 1"
                )
            
            case let .failure(error): XCTFail("\(error)")
                
            }
            
        }
        
        storage.value(forKey: "second") { result in
            
            secondValuePromise.fulfill()
            
            switch result {
                
            case let .success(value):
                
                XCTAssertEqual(
                    value,
                    "second value from storage 2"
                )
                
            case let .failure(error): XCTFail("\(error)")
                
            }
            
        }
        
        wait(
            for: [
                firstValuePromise,
                secondValuePromise
            ],
            timeout: 10.0
        )
        
    }

}
