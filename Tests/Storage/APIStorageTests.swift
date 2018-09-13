//
//  APIStorageTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - APIStorageTests

import TinyCore
import XCTest

@testable import TinyKit

internal final class MessageResource: Resource {
    
    internal typealias Message = String
    
    internal final func fetchItems(
        page: Page,
        completionHandler: @escaping (Result<FetchItemsPayload<Message>>) -> Void
    ) {
        
        completionHandler(
            .success(
                FetchItemsPayload(
                    items: [
                        "Hello",
                        "World"
                    ],
                    next: nil
                )
            )
        )
        
    }
    
}

internal final class APIStorageTests: XCTestCase {
    
    internal final var subscriptions: [ObservableSubscription] = []
    
    internal final func test() {
        
        let promise = expectation(description: "Load items from a given resource.")

        let storage = APIStorage(
            resource: MessageResource()
        )

        let subscription = storage.keyDiff.subscribe { event in

            promise.fulfill()

            XCTFail()

        }
        
        subscriptions.append(subscription)
        
        storage.load()
        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
