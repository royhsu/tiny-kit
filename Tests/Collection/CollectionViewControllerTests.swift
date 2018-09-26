//
//  CollectionViewControllerTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/9/26.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionViewControllerTests

import XCTest

@testable import TinyKit

internal final class CollectionViewControllerTests: XCTestCase {
    
    internal final func testInitialize() {
        
        let controller = NewCollectionViewController()
        
        XCTAssert(controller.sections.isEmpty)
        
        XCTAssertNil(controller.layout)
        
    }
    
    internal final func test() {
        
        let controller = NewCollectionViewController()
        
        #warning("find a better way to automate this kind of view loading.")
        controller.loadViewIfNeeded()
        
        controller.layout = TableViewLayout()
        
        let viewA = View()
        
        let viewB = View()
        
        let viewC = View()
        
        controller.sections = [
            [ viewA ],
            [ viewB, viewC ]
        ]
        
        controller.layout?.invalidate()
        
        XCTAssertEqual(
            controller.layout?.numberOfSections,
            2
        )
        
        XCTAssertEqual(
            controller.layout?.numberOfItems(atSection: 0),
            1
        )

        XCTAssertEqual(
            controller.layout?.numberOfItems(atSection: 1),
            2
        )

        #warning("cannot get the view due to the cell is invisible.")
//        XCTAssert(
//            controller.layout?.viewForItem(
//                at: IndexPath(
//                    item: 0,
//                    section: 0
//                )
//            )
//            === viewA
//        )

//        XCTAssert(
//            controller.layout?.viewForItem(
//                at: IndexPath(
//                    item: 1,
//                    section: 0
//                )
//            )
//            === viewB
//        )

//        XCTAssert(
//            controller.layout?.viewForItem(
//                at: IndexPath(
//                    item: 1,
//                    section: 2
//                )
//            )
//            === viewC
//        )

    }
    
}
