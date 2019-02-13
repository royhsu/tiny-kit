//
//  PageManagerTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/2/13.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - PageManagerTests

import XCTest

@testable import TinyKit

final class PageManagerTests: XCTestCase {
    
    func testDefault() {
        
        let currentPage = Page<Message, Message.Cursor>(
            elements: [
                Message(text: "b"),
                Message(text: "c")
            ]
        )
        
        let manager = PageManager(
            currentPages: [ currentPage ],
            previousPage: InactivePage(
                cursor: Message(text: "a").cursor,
                elementCount: 1
            ),
            nextPage: InactivePage(
                cursor: Message(text: "e").cursor,
                elementCount: 2
            )
        )
        
        XCTAssert(manager.hasPreviousPage)
        
        XCTAssert(manager.hasNextPage)
        
        XCTAssertEqual(
            manager.elementStates,
            [ .inactive ] // Previous page
            + currentPage.elements.map { .fetched($0) } // Current pages
            + [ .inactive, .inactive ] // Next page
        )
        
    }
    
}
