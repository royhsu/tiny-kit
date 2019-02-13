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
    
    func testFetchAllElements() throws {
        
        enum Step {
            
            case waitForFetchingFirstPageElements
            
            case waitForFetchedFirstPageElements
            
            case waitForFetchingLastPageElements
            
            case waitForFetchedLastPageElements
            
        }
        
        var currentStep: Step = .waitForFetchingFirstPageElements
        
        let firstPageElementsFetching = expectation(description: "Before the first page of elements fetched.")
        
        let firstPageElementsFetched = expectation(description: "After the first page of elements fetched.")
        
        let lastPageElementsFetching = expectation(description: "Before the last page of elements fetched.")
        
        let lastPageElementsFetched = expectation(description: "After the last page of elements fetched.")
        
        let controller = PaginationController(
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
            
            let elementStates = controller.elementStates
            
            switch currentStep {

            case .waitForFetchingFirstPageElements:

                defer { firstPageElementsFetching.fulfill() }

                XCTAssertEqual(
                    elementStates,
                    [
                        .fetching,
                        .fetching
                    ]
                )

                currentStep = .waitForFetchedFirstPageElements

            case .waitForFetchedFirstPageElements:

                defer { firstPageElementsFetched.fulfill() }
                
                XCTAssertFalse(controller.hasPreviousPage)
                
                XCTAssert(controller.hasNextPage)

                XCTAssertEqual(
                    elementStates,
                    [
                        .fetched( Message(text: "a") ),
                        .inactive,
                        .inactive
                    ]
                )
                
                currentStep = .waitForFetchingLastPageElements

                try! controller.performFetchForNextPage()

            case .waitForFetchingLastPageElements:

                defer { lastPageElementsFetching.fulfill() }
                
                XCTAssertEqual(
                    elementStates,
                    [
                        .fetched( Message(text: "a") ),
                        .fetching,
                        .fetching
                    ]
                )

                currentStep = .waitForFetchedLastPageElements

            case .waitForFetchedLastPageElements:

                defer { lastPageElementsFetched.fulfill() }

                XCTAssertFalse(controller.hasPreviousPage)
                
                XCTAssertFalse(controller.hasNextPage)
                
                XCTAssertEqual(
                    elementStates,
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
                firstPageElementsFetching,
                firstPageElementsFetched,
                lastPageElementsFetching,
                lastPageElementsFetched
            ],
            timeout: expectationTimeout
        )
        
    }
    
}
