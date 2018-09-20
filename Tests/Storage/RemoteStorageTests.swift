//
//  RemoteStorageTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - RemoteStorageTests

import TinyCore
import XCTest

@testable import TinyKit

internal final class RemoteStorageTests: XCTestCase {

    internal final var subscriptions: [ObservableSubscription] = []
    
    internal final func testInitialize() {
        
        let storage = RemoteStorage(
            resource: MessageResource(
                fetchItemsResult: .success(
                    FetchItemsPayload(
                        items: [
                            "Hello",
                            "World"
                        ],
                        next: nil
                    )
                )
            )
        )
        
        XCTAssert(storage.isEmpty)
        
    }
    
    internal final func testLoad() {
        
        let promise = expectation(description: "Load the storage.")
        
        let storage = RemoteStorage(
            resource: MessageResource(
                fetchItemsResult: .success(
                    FetchItemsPayload(
                        items: [
                            "Hello",
                            "World"
                        ],
                        next: nil
                    )
                )
            )
        )
        
        XCTAssertFalse(storage.isLoaded)
        
        storage.load { result in
            
            promise.fulfill()
            
            switch result {
                
            case .success:
                
                XCTAssertEqual(
                    storage.count,
                    2
                )
                
                XCTAssertEqual(
                    storage[0],
                    "Hello"
                )
                
                XCTAssertEqual(
                    storage[1],
                    "World"
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
        
        let promise = self.expectation(description: "Remove all values.")
        
        var isRemoved = false
        
        let storage = RemoteStorage(
            resource: MessageResource(
                fetchItemsResult: .success(
                    FetchItemsPayload(
                        items: [ "Hello" ],
                        next: nil
                    )
                )
            )
        )
        
        subscriptions.append(
            storage.changes.subscribe { event in
                
                guard isRemoved else { return }
                
                promise.fulfill()
                
                let changes = event.currentValue
                
                XCTAssertEqual(
                    changes?.count,
                    1
                )
                
                let removeValueChange = changes?.first { $0.key == 0 }
                
                XCTAssertNotNil(removeValueChange)
                
                XCTAssertEqual(
                    removeValueChange?.value,
                    "Hello"
                )
                
            }
        )
        
        storage.load { _ in
            
            isRemoved = true
            
            storage.removeAll()
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }

}
