//
//  PaginationIndexManagerTests.swift
//  TinyKnowledgeTests
//
//  Created by Roy Hsu on 2019/2/12.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PaginationIndexManagerTests

import XCTest

@testable import TinyKit

final class PaginationIndexManagerTests: XCTestCase {
    
    func testDefault() {
        
        let manager = PaginationIndexManager()
        
        XCTAssert(manager.fetchingIndices.isEmpty)
        
    }
    
    func testStartFetching() {
        
        let manager = PaginationIndexManager()
        
        manager.startFetching(for: 0)
        
        manager.startFetching(for: 3)
        
        XCTAssertEqual(
            manager.fetchingIndices,
            [ 0, 3 ]
        )
        
    }
    
    func testEndFetching() {
        
        let manager = PaginationIndexManager()
        
        manager.startFetching(for: 0)
        
        manager.startFetching(for: 3)
        
        manager.endFetching(for: 3)
        
        XCTAssertEqual(
            manager.fetchingIndices,
            [ 0 ]
        )
        
    }
    
    func testEndAllFetchings() {
        
        let manager = PaginationIndexManager()
        
        manager.startFetching(for: 0)
        
        manager.startFetching(for: 3)
        
        manager.endAllFetchings()
        
        XCTAssert(manager.fetchingIndices.isEmpty)
        
    }
    
}
