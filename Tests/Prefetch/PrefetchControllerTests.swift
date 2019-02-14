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
            fetchTimer: Timer(),
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
            
            case waitForFetchingMiddlePage
            
            case waitForFetchedMiddlePage
            
            case waitForFetchingFirstPage
            
            case waitForFetchedFirstPage
            
            case waitForFetchingLastPage
            
            case waitForFetchedLastPage
            
        }
        
        var currentStep: Step = .waitForFetchingMiddlePage
        
        let middlePageFetching = expectation(description: "Before the middle page fetched.")
        
        let middlePageFetched = expectation(description: "After the middle page fetched.")
        
        let firstPageFetching = expectation(description: "Before the first page fetched.")
        
        let firstPageFetched = expectation(description: "After the first page fetched.")
        
        let lastPageFetching = expectation(description: "Before the last page fetched.")
        
        let lastPageFetched = expectation(description: "After the last page fetched.")
        
        let fetchTimer = Timer()
        
        let controller = PrefetchController(
            fetchTimer: fetchTimer,
            fetchRequest: FetchRequest(
                fetchCursor: .middle,
                fetchLimit: 2
            ),
            fetchService: MessageService(
                result: .success(
                    .init(
                        firstPageMessages: [ Message(text: "a") ],
                        middlePageMessages: [ Message(text: "b") ],
                        lastPageMessages: [ Message(text: "c") ]
                    )
                )
            )
        )
        
        controller.elementStatesDidChange = { controller in
            
            switch currentStep {

            case .waitForFetchingMiddlePage:

                defer { middlePageFetching.fulfill() }

                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetching,
                        .fetching
                    ]
                )

                currentStep = .waitForFetchedMiddlePage

            case .waitForFetchedMiddlePage:

                defer { middlePageFetched.fulfill() }

                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .inactive,
                        .inactive,
                        .fetched( Message(text: "b") ),
                        .inactive,
                        .inactive
                    ]
                )
                
                currentStep = .waitForFetchingFirstPage
                
                self.prefetchElements(for: controller)
                
                fetchTimer.timeOut()

            case .waitForFetchingFirstPage:
                
                defer { firstPageFetching.fulfill() }
                
                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetching,
                        .fetching,
                        .fetched( Message(text: "b") ),
                        .inactive,
                        .inactive
                    ]
                )
                
                currentStep = .waitForFetchedFirstPage

            case .waitForFetchedFirstPage:
                
                defer { firstPageFetched.fulfill() }
                
                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetched( Message(text: "a") ),
                        .fetched( Message(text: "b") ),
                        .inactive,
                        .inactive
                    ]
                )
                
                currentStep = .waitForFetchingLastPage
                
                self.prefetchElements(for: controller)
                
                fetchTimer.timeOut()
                
            case .waitForFetchingLastPage:
                
                defer { lastPageFetching.fulfill() }
                
                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetched( Message(text: "a") ),
                        .fetched( Message(text: "b") ),
                        .fetching,
                        .fetching
                    ]
                )
                
                currentStep = .waitForFetchedLastPage
                
            case .waitForFetchedLastPage:
                
                defer { lastPageFetched.fulfill() }

                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetched( Message(text: "a") ),
                        .fetched( Message(text: "b") ),
                        .fetched( Message(text: "c") )
                    ]
                )
                
            }
            
        }
        
        try controller.performFetch()
        
        wait(
            for: [
                middlePageFetching,
                middlePageFetched,
                firstPageFetching,
                firstPageFetched,
                lastPageFetching,
                lastPageFetched
            ],
            timeout: expectionTimeout
        )
        
    }
    
}

extension PrefetchControllerTests {
    
    private func prefetchElements<Element, Cursor>(
        for controller: (PrefetchController<Element, Cursor>)
    ) {
        
        // This will trigger the controller to prefetch the next page automatically.
        let inactiveState = controller.elementStates.first {
            
            if case .inactive = $0 { return true }
            
            return false
            
        }
        
        XCTAssertNotNil(inactiveState)
        
    }
    
}
