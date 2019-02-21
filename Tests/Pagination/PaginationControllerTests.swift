//
//  PaginationControllerTests.swift
//  TinyKnowledgeTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PaginationControllerTests

import XCTest

@testable import TinyKit

final class PaginationControllerTests: XCTestCase {
    
    private let expectationTimeout = 5.0
    
    func testDefault() {
        
        let controller = PaginationController(
            fetchService: MessageService(
                result: .success(
                    .init(firstPageMessages: [] )
                )
            )
        )
        
        XCTAssert(controller.elementStates.isEmpty)
        
        XCTAssertFalse(controller.isFetching)
        
        XCTAssertFalse(controller.hasPreviousPage)
        
        XCTAssertFalse(controller.hasNextPage)
        
    }
    
    func testFetchElementsWithError() throws {
        
        enum Step {
            
            case waitForFetchingElements, waitForFetchedElements
            
        }
        
        var currentStep: Step = .waitForFetchingElements
        
        let errorElementsAfterFetched = expectation(description: "Fetch error elements.")
        
        let controller = PaginationController(
            fetchService: MessageService(
                result: .failure( MessageError() )
            )
        )
        
        controller.elementStatesDidChange = { controller in
            
            switch currentStep {
            
            case .waitForFetchingElements: currentStep = .waitForFetchedElements
            
            case .waitForFetchedElements:
                
                defer { errorElementsAfterFetched.fulfill() }
                
                XCTAssertEqual(
                    controller.elementStates,
                    [ .error ]
                )
                
            }
            
        }
        
        try controller.performFetch()
        
        wait(
            for: [ errorElementsAfterFetched ],
            timeout: expectationTimeout
        )
        
    }
    
    func testFetchAllElementsFromMiddlePage() throws {
        
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
        
        let controller = PaginationController(
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
            
            do {
            
                let elementStates = controller.elementStates
                
                switch currentStep {

                case .waitForFetchingMiddlePage:
                    
                    defer { middlePageFetching.fulfill() }
                    
                    XCTAssert(controller.isFetching)
                    
                    XCTAssertEqual(
                        elementStates,
                        [
                            .fetching,
                            .fetching
                        ]
                    )
                    
                    currentStep = .waitForFetchedMiddlePage
                    
                case .waitForFetchedMiddlePage:
                    
                    defer { middlePageFetched.fulfill() }
                    
                    XCTAssertFalse(controller.isFetching)
                    
                    XCTAssert(controller.hasPreviousPage)
                    
                    XCTAssert(controller.hasNextPage)
                    
                    XCTAssertEqual(
                        elementStates,
                        [
                            .inactive,
                            .inactive,
                            .fetched( Message(text: "b") ),
                            .inactive,
                            .inactive
                        ]
                    )
                    
                    currentStep = .waitForFetchingFirstPage
                    
                    try controller.performFetchForPreviousPage()
                    
                case .waitForFetchingFirstPage:

                    defer { firstPageFetching.fulfill() }

                    XCTAssert(controller.isFetching)
                    
                    XCTAssertEqual(
                        elementStates,
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
                    
                    XCTAssertFalse(controller.hasPreviousPage)

                    XCTAssertEqual(
                        elementStates,
                        [
                            .fetched( Message(text: "a") ),
                            .fetched( Message(text: "b") ),
                            .inactive,
                            .inactive
                        ]
                    )
                    
                    currentStep = .waitForFetchingLastPage
                    
                    try controller.performFetchForNextPage()
                    
                case .waitForFetchingLastPage:

                    defer { lastPageFetching.fulfill() }
                    
                    XCTAssert(controller.isFetching)
                    
                    XCTAssertEqual(
                        elementStates,
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
                    
                    XCTAssertFalse(controller.hasNextPage)
                    
                    XCTAssertEqual(
                        elementStates,
                        [
                            .fetched( Message(text: "a") ),
                            .fetched( Message(text: "b") ),
                            .fetched( Message(text: "c") )
                        ]
                    )

                }
                
            }
            catch { XCTFail("\(error)") }
            
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
            timeout: expectationTimeout
        )
        
    }
    
}
