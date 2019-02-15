//
//  PrefetchTaskManagerTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/15.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PrefetchTaskManagerTests

import XCTest

@testable import TinyKit

final class PrefetchTaskManagerTests: XCTestCase {
    
    private let expectationTimeout = 5.0
    
    func testScheduleTasks() {
        
        let prefetchForPreviousPage = expectation(description: "Perform prefetch for the previous page.")
        
        let prefetchForNextPage = expectation(description: "Perform prefetch for the next page.")
        
        let allTasks = expectation(description: "Execute all the tasks.")
        
        let manager = PrefetchTaskManager()
        
        manager.tasks[.next] = { manager, completion in
            
            defer {
                
                prefetchForNextPage.fulfill()
                
                completion()
                
            }
            
            XCTAssert(manager.isExecutingTasks)
            
            XCTAssertNil(
                manager.tasks[.next]
            )
            
        }
        
        manager.tasks[.previous] = { manager, completion in
            
            defer {
                
                prefetchForPreviousPage.fulfill()
                
                completion()
                
            }
            
            XCTAssert(manager.isExecutingTasks)
            
            XCTAssertNil(
                manager.tasks[.previous]
            )
            
            XCTAssertNotNil(
                manager.tasks[.next]
            )
            
        }
        
        manager.executeAllTasks { _ in
            
            defer { allTasks.fulfill() }
            
            XCTAssertFalse(manager.isExecutingTasks)
            
            XCTAssert(manager.tasks.isEmpty)
            
        }
        
        wait(
            for: [
                prefetchForPreviousPage,
                prefetchForNextPage,
                allTasks
            ],
            timeout: expectationTimeout
        )
        
    }
    
}
