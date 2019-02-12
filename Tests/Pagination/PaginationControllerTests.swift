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
    
    func testPerformFetch() throws {
        
        enum Step {
            
            case waitForFetchingElements, waitForFetchedElements
            
        }
        
        var currentStep: Step = .waitForFetchingElements
        
        let elementsFetching = expectation(description: "Before elements fetched.")
        
        let elementsFetched = expectation(description: "After elements fetched.")
        
        let messages = [
            Message(text: "a"),
            Message(text: "b"),
            Message(text: "c")
        ]
        
        let controller = PaginationController(
            fetchRequest: FetchRequest(fetchLimit: 2),
            fetchService: MessagesService(
                result: .success(messages)
            )
        )
        
        controller.elementStatesDidChange = { controller in
            
            switch currentStep {
                
            case .waitForFetchingElements:
            
                defer { elementsFetching.fulfill() }
                
                let fetchedResults = controller.storage.elementStates

                XCTAssertEqual(
                    fetchedResults,
                    [
                        .fetching,
                        .fetching
                    ]
                )
                
                for fetchingIndex in controller.fetchIndexManager.fetchingIndices {
                    
                    XCTAssert(
                        fetchedResults.indices.contains(fetchingIndex)
                    )
                    
                }
                
                currentStep = .waitForFetchedElements
                
            case .waitForFetchedElements:
                
                defer { elementsFetched.fulfill() }
                
                let fetchedResults = controller.storage.elementStates
                
                XCTAssertEqual(
                    fetchedResults,
                    messages.map { .fetched($0) }
                )
                
                XCTAssert(controller.fetchIndexManager.fetchingIndices.isEmpty)
                
            }
            
        }
        
        XCTAssert(controller.storage.elementStates.isEmpty)
        
        try controller.performFetch()

        wait(
            for: [
                elementsFetching,
                elementsFetched
            ],
            timeout: expectationTimeout
        )
        
    }
    
    func testFetchElementsWithError() throws {
        
        enum Step {
            
            case waitForFetchingElements, waitForFetchedElements
            
        }
        
        var currentStep: Step = .waitForFetchingElements
        
        let errorElementsAfterFetched = expectation(description: "Fetch error elements.")
        
        let controller = PaginationController(
            fetchService: MessagesService(
                result: .failure( MessageError() )
            )
        )
        
        controller.elementStatesDidChange = { controller in
            
            switch currentStep {
            
            case .waitForFetchingElements: currentStep = .waitForFetchedElements
            
            case .waitForFetchedElements:
                
                defer { errorElementsAfterFetched.fulfill() }
                
                XCTAssertEqual(
                    controller.storage.elementStates,
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
    
}
