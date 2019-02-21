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
        
        XCTAssertFalse(controller.isFetching)
        
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

                XCTAssert(controller.isFetching)
                
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

                XCTAssertFalse(controller.isFetching)
                
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
                
                guard
                    let pretchableIndex = controller.elementStates.firstIndex(
                        where: {
                            
                            if case .inactive = $0 { return true }
                            
                            return false
                            
                        }
                    )
                else { XCTFail("There must be a fetchable index."); return }
                
                controller.prefetchIndices = [ pretchableIndex ]
                
                fetchTimer.timeOut()

            case .waitForFetchingFirstPage:
                
                defer { firstPageFetching.fulfill() }
                
                XCTAssert(controller.isFetching)
                
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
                
                XCTAssertFalse(controller.isFetching)
                
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
                
                guard
                    let pretchableIndex = controller.elementStates.firstIndex(
                        where: {
                    
                            if case .inactive = $0 { return true }
                    
                            return false
                    
                        }
                    )
                else { XCTFail("There must be a fetchable index."); return }
                
                controller.prefetchIndices = [ pretchableIndex ]
                
                fetchTimer.timeOut()
                
            case .waitForFetchingLastPage:
                
                defer { lastPageFetching.fulfill() }
                
                XCTAssert(controller.isFetching)
                
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

                XCTAssertFalse(controller.isFetching)
                
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
