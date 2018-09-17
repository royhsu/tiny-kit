//
//  APIManagerTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - APIManagerTests

import TinyCore
import XCTest

@testable import TinyKit

internal final class APIManagerTests: XCTestCase {
    
    internal final var subscriptions: [ObservableSubscription] = []
    
    internal final func testLoad() {
        
        let promise = expectation(description: "Load items from a given resource.")

        let manager = APIManager(
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
        
        let storage = AnyStorage(manager)

        let subscription = storage.keyDiff.subscribe { event in

            promise.fulfill()
            
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
        
        subscriptions.append(subscription)
        
        manager.load()
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
