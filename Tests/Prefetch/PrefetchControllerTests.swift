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
        
        let fetchTimer = Timer()
        
        let controller = PrefetchController(
            fetchTimer: fetchTimer,
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
                
                self.prefetchElements(for: controller)
                
                fetchTimer.timeOut()

            case .waitForFetchingLastPage:
                
                defer { lastPageFetching.fulfill() }
                
                XCTAssertEqual(
                    controller.elementStates,
                    [
                        .fetched( Message(text: "a") ),
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
                        .fetched( Message(text: "b") )
                    ]
                )

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
