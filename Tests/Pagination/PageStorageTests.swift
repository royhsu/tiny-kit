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
        
        let result = storage.reduce()
        
        XCTAssertEqual(
            result.elementStates,
            []
        )
        
        XCTAssertEqual(
            result.currentPagesElementStateIndices,
            []
        )
        
        XCTAssertNil(result.previousPageElementStateIndices)
        
        XCTAssertNil(result.nextPageElementStateIndices)
        
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
        
        let result = storage.reduce()
        
        XCTAssertEqual(
            result.elementStates,
            [
                .inactive,
                .fetched("a")
            ]
        )
        
        XCTAssertEqual(
            result.previousPageElementStateIndices,
            [ 0 ]
        )
        
        XCTAssertEqual(
            result.currentPagesElementStateIndices,
            [ 1 ]
        )
        
        XCTAssertNil(result.nextPageElementStateIndices)
        
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
        
        let result = storage.reduce()
        
        XCTAssertEqual(
            result.elementStates,
            [
                .fetched("a"),
                .fetching,
                .fetching
            ]
        )
        
        XCTAssertNil(result.previousPageElementStateIndices)
        
        XCTAssertEqual(
            result.currentPagesElementStateIndices,
            [ 0 ]
        )

        XCTAssertEqual(
            result.nextPageElementStateIndices,
            [ 1, 2 ]
        )
        
    }
    
    func testReduce() {
        
        struct Cursor { }
        
        let currentPage = Page<String, Cursor>(elements: [ "b", "c" ] )
        
        let storage = PageStorage(
            currentPages: [ currentPage ],
            previousPage: StatefulPage(
                state: .inactive,
                cursor: Cursor(),
                elementCount: 3
            ),
            nextPage: StatefulPage(
                state: .fetching,
                cursor: Cursor(),
                elementCount: 4
            )
        )
        
        let result = storage.reduce()
        
        XCTAssertEqual(
            result.elementStates,
            [
                .inactive,
                .inactive,
                .inactive,
                .fetched("b"),
                .fetched("c"),
                .fetching,
                .fetching,
                .fetching,
                .fetching
            ]
        )
        
        XCTAssertEqual(
            result.previousPageElementStateIndices,
            [ 0, 1, 2 ]
        )
        
        XCTAssertEqual(
            result.currentPagesElementStateIndices,
            [ 3, 4 ]
        )
        
        XCTAssertEqual(
            result.nextPageElementStateIndices,
            [ 5, 6, 7, 8 ]
        )
        
    }
    
}
