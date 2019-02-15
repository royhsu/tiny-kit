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
        
        let manager = PrefetchTaskManager()
        
        manager.tasks[.next] = { manager, completion in
            
            defer {
                
                prefetchForNextPage.fulfill()
                
                completion()
                
            }
            
            XCTAssertNil(
                manager.tasks[.next]
            )
            
        }
        
        manager.tasks[.previous] = { manager, completion in
            
            defer {
                
                prefetchForPreviousPage.fulfill()
                
                completion()
                
            }
            
            XCTAssertNil(
                manager.tasks[.previous]
            )
            
            XCTAssertNotNil(
                manager.tasks[.next]
            )
            
        }
        
        manager.executeAllTasks()
        
        wait(
            for: [
                prefetchForPreviousPage,
                prefetchForNextPage
            ],
            timeout: expectationTimeout
        )
        
    }
    
}
