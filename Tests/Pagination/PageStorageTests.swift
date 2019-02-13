//
//  PageStorageTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/13.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PageStorageTests

import XCTest

@testable import TinyKit

final class PageStorageTests: XCTestCase {
    
    func testDefault() {
        
        struct Cursor { }
        
        let storage = PageStorage<String, Cursor>()
        
        XCTAssertFalse(storage.hasPreviousPage)
        
        XCTAssertFalse(storage.hasNextPage)
        
        XCTAssertEqual(
            storage.elementStates,
            []
        )
        
    }
    
    func testPreviousPageWithInactiveStates() {
        
        struct Cursor { }
        
        let currentPage = Page<String, Cursor>(elements: [ "a" ] )
        
        let storage = PageStorage(
            currentPages: [ currentPage ],
            previousPage: StatefulPage(
                state: .inactive,
                cursor: Cursor(),
                elementCount: 1
            )
        )
        
        XCTAssert(storage.hasPreviousPage)
        
        XCTAssertEqual(
            storage.elementStates,
            [
                .inactive,
                .fetched("a")
            ]
        )
        
    }
    
    func testNextPageWithFetchingStates() {
        
        struct Cursor { }
        
        let currentPage = Page<String, Cursor>(elements: [ "a" ] )
        
        let storage = PageStorage(
            currentPages: [ currentPage ],
            nextPage: StatefulPage(
                state: .fetching,
                cursor: Cursor(),
                elementCount: 2
            )
        )
        
        XCTAssert(storage.hasNextPage)
        
        XCTAssertEqual(
            storage.elementStates,
            [
                .fetched("a"),
                .fetching,
                .fetching
            ]
        )
        
    }
    
}
