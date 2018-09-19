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

    internal final func testGetItemsForKeyAsynchronously() {

        let promise = expectation(description: "Load items from a given resource while there is no matched item for the key.")
        
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
        
        storage.value(forKey: 1) { result in
            
            promise.fulfill()
            
            switch result {
                
            case let .success(item):
                
                XCTAssertEqual(
                    item,
                    "World"
                )
                
            case let .failure(error): XCTFail("\(error)")
                
            }
            
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
            
        }

        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }

}
