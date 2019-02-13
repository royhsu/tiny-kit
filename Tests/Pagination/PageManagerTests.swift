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
        
        enum Cursor {
            
            case first, second, third
            
        }
        
        let currentPage = Page<Message, Cursor>(
            elements: [
                Message(text: "b"),
                Message(text: "c")
            ]
        )
        
        let manager = PageStorage(
            currentPages: [ currentPage ],
            previousPage: StatefulPage(
                state: .inactive,
                cursor: .first,
                elementCount: 1
            ),
            nextPage: StatefulPage(
                state: .fetching,
                cursor: .third,
                elementCount: 2
            )
        )
        
        XCTAssert(manager.hasPreviousPage)
        
        XCTAssert(manager.hasNextPage)
        
        XCTAssertEqual(
            manager.elementStates,
            [ .inactive ] // Previous page
            + currentPage.elements.map { .fetched($0) } // Current pages
            + [ .fetching, .fetching ] // Next page
        )
        
    }
    
}
