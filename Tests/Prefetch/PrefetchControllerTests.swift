//
//  PrefetchControllerTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchControllerTests

import XCTest

@testable import TinyKit

final class PrefetchControllerTests: XCTestCase {
    
    private let expectionTimeout = 5.0
    
    func testDefault() {
        
        let controller = PrefetchController(
            fetchService: MessageService(
                result: .success(
                    .init(firstPageMessages: [] )
                )
            )
        )
        
        XCTAssert(controller.elementStates.isEmpty)
        
    }
    
    func testFetchAllElementsByPrefetching() throws {
        
        enum Step {
            
            case waitForFetchingFirstPage
            
            case waitForFetchedFirstPage
            
            case waitForFetchingLastPage
            
            case waitForFetchedLastPage
            
        }
        
        var currentStep: Step = .waitForFetchingFirstPage
        
        let firstPageFetching = expectation(description: "Before the first page fetched.")
        
        let firstPageFetched = expectation(description: "After the first page fetched.")
        
        let lastPageFetching = expectation(description: "Before the last page fetched.")
        
        let lastPageFetched = expectation(description: "After the last page fetched.")
        
        let controller = PrefetchController(
            fetchRequest: FetchRequest(fetchLimit: 2),
            fetchService: MessageService(
                result: .success(
                    .init(
                        firstPageMessages: [ Message(text: "a") ],
                        lastPageMessages: [ Message(text: "b") ]
                    )
                )
            )
        )
        
        controller.elementStatesDidChange = { controller in
            
            switch currentStep {

            case .waitForFetchingFirstPage:

                defer { firstPageFetching.fulfill() }

                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetching,
                        .fetching
                    ]
                )

                currentStep = .waitForFetchedFirstPage

            case .waitForFetchedFirstPage:

                defer { firstPageFetched.fulfill() }

                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetched( Message(text: "a") ),
                        .inactive,
                        .inactive
                    ]
                )

                currentStep = .waitForFetchingLastPage

            case .waitForFetchingLastPage: XCTFail()

            case .waitForFetchedLastPage: XCTFail()

            }
            
        }
        
        try controller.performFetch()
        
        wait(
            for: [
                firstPageFetching,
                firstPageFetched,
                lastPageFetching,
                lastPageFetched
            ],
            timeout: expectionTimeout
        )
        
    }
    
}
