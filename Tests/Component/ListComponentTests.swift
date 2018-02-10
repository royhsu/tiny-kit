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
    
    internal final func testRenderListComponent() {
        
        let promise = expectation(description: "Render a list component.")
        
        let redPreferredContentSize = CGSize(
            width: 100.0,
            height: 100.0
        )
        
        let redView = RectangleView()
        
        redView.frame = CGRect(
            origin: .zero,
            size: redPreferredContentSize
        )
        
        let redComponent = ColorComponent(
            view: redView,
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
        
        let blueView = RectangleView()
        
        let bluePreferredContentSize = CGSize(
            width: 200.0,
            height: 200.0
        )
        
        blueView.frame = CGRect(
            origin: .zero,
            size: bluePreferredContentSize
        )
        
        let blueComponent = ColorComponent(
            view: blueView,
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
        
        let colorComponents: [Component] = [
            redComponent,
            blueComponent
        ]
        
        let listComponent = ListComponent()
        
        listComponent.itemComponents = AnyCollection(colorComponents)
        
        listComponent
            .render()
            .then(in: .main) {

                XCTAssertEqual(
                    listComponent.view as? UITableView,
                    listComponent.tableView
                )
                
                XCTAssertEqual(
                    listComponent.tableView.numberOfSections,
                    Int(listComponent.itemComponents.count)
                )
                
                guard
                    let redSection = colorComponents.index(
                        where: { $0 as? ColorComponent === redComponent }
                    )
                else {
                    
                    XCTFail("There should be a section for the red component.")
                    
                    return
                    
                }
                
                XCTAssertEqual(
                    listComponent.tableView.numberOfRows(inSection: redSection),
                    1
                )
                
                let redCell = listComponent.tableView.cellForRow(
                    at: IndexPath(
                        row: 0,
                        section: redSection
                    )
                )
                
                XCTAssertEqual(
                    redCell?.contentView.subviews.first,
                    redView
                )
                
                guard
                    let blueSection = colorComponents.index(
                        where: { $0 as? ColorComponent === blueComponent }
                    )
                else {
                    
                    XCTFail("There should be a section for the blue component.")
                    
                    return
                    
                }
                
                XCTAssertEqual(
                    listComponent.tableView.numberOfRows(inSection: blueSection),
                    1
                )
        
                let blueCell = listComponent.tableView.cellForRow(
                    at: IndexPath(
                        row: 0,
                        section: blueSection
                    )
                )
                
                XCTAssertEqual(
                    blueCell?.contentView.subviews.first,
                    blueView
                )
                
                XCTAssertEqual(
                    listComponent.preferredContentSize,
                    listComponent.tableView.contentSize
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
