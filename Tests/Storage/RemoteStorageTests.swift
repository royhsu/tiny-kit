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

    internal final func testLoad() {

        let promise = expectation(description: "Load items from a given resource.")

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
        
        let subscription = storage.changes.subscribe { event in

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

        storage.load()

        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }

}
