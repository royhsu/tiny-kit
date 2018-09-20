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
    
    internal final func testSetValue() {
        
        let promise = expectation(description: "Get notified about changes.")
        
        var isLoaded = false
        
        var storage = RemoteStorage(
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
                
                guard
                    isLoaded
                else { return }
                
                promise.fulfill()
                
                let changes = event.currentValue
                
                XCTAssertEqual(
                    changes?.count,
                    1
                )
                
                let valueChange = changes?.first { $0.key == 1 }
                
                XCTAssert(valueChange != nil)
                
                XCTAssertEqual(
                    valueChange?.value,
                    "World"
                )
                
            }
        )
        
        storage.load { _ in
            
            isLoaded = true
            
            storage[1] = "World"
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
    internal final func testMergeValues() {
        
        let promise = expectation(description: "Get notified about changes.")
        
        var isLoaded = false
        
        let storage = RemoteStorage(
            resource: MessageResource(
                fetchItemsResult: .success(
                    FetchItemsPayload(
                        items: [ "existing", "replacing" ],
                        next: nil
                    )
                )
            )
        )
        
        let subscription = storage.changes.subscribe { event in
            
            guard
                isLoaded
            else { return }
                
            promise.fulfill()
            
            let changes = event.currentValue
            
            XCTAssertEqual(
                changes?.count,
                2
            )
            
            let existingValueChange = changes?.first { $0.key == 0 }
            
            XCTAssert(existingValueChange == nil)
            
            let replaceValueChange = changes?.first { $0.key == 1 }
            
            XCTAssert(replaceValueChange != nil)
            
            XCTAssertEqual(
                replaceValueChange?.value,
                "replaced"
            )
            
            let newValueChange = changes?.first { $0.key == 2 }
            
            XCTAssert(newValueChange != nil)
            
            XCTAssertEqual(
                newValueChange?.value,
                "new"
            )
            let nilValueChange = changes?.first { $0.key == 3 }
            
            XCTAssert(nilValueChange == nil)
            
            XCTAssertEqual(
                storage.count,
                3
            )
            
        }
        
        subscriptions.append(subscription)
        
        storage.load { _ in
            
            isLoaded = true
            
            let newElements: [ (Int, String?) ] =  [
                (1, "replaced"),
                (2, "new"),
                (3, nil)
            ]
    
            storage.merge(
                AnySequence(newElements)
            )
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
    internal final func testRemoveAll() {
        
        let promise = expectation(description: "Remove all values.")
        
        var isLoaded = false
        
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
                
                guard
                    isLoaded
                else { return }
                
                promise.fulfill()
                
                let changes = event.currentValue
                
                XCTAssertEqual(
                    changes?.count,
                    1
                )
                
                let removeValueChange = changes?.first { $0.key == 0 }
                
                XCTAssert(removeValueChange != nil)
                
                XCTAssertEqual(
                    removeValueChange?.value,
                    "Hello"
                )
                
            }
        )
        
        storage.load { _ in
            
            isLoaded = true
            
            storage.removeAll()
            
        }
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }

}
