//
//  ListComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponentTests

import XCTest

@testable import TinyKit

internal final class ListComponentTests: XCTestCase {
    
    internal final func testListComponent() {
        
        let promise = expectation(description: "Render a list component.")
        
        let listComponent = ListComponent()
        
        let redItemComponent = ItemComponent(
            view: RectangleView(),
            model: Color(
                red: 1.0,
                green: 0.0,
                blue: 0.0,
                alpha: 1.0
            ),
            binding: { colorView, color in
        
                colorView.backgroundColor = color.uiColor()
                
            }
        )
        
        let blueItemComponent = ItemComponent(
            view: RectangleView(),
            model: Color(
                red: 0.0,
                green: 0.0,
                blue: 1.0,
                alpha: 1.0
            ),
            binding: { colorView, color in
                
                colorView.backgroundColor = color.uiColor()
                
            }
        )
        
        listComponent.addChild(redItemComponent)
        
        listComponent.addChild(blueItemComponent)
        
        listComponent
            .render()
            .then(in: .main) {

                guard
                    let tableView = listComponent.view as? UITableView
                else {

                    XCTFail("The view of list component must be a table view.")

                    return

                }

                XCTAssertEqual(
                    tableView.numberOfSections,
                    Int(listComponent.childs.count)
                )

            }
            .catch(in: .main) { XCTFail("\($0)") }
            .always(in: .main) { promise.fulfill() }

        
        wait(
            for: [ promise ],
            timeout: 10.0
        )
        
    }
    
}
