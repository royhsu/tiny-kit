//
//  UIListComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponentTests

import XCTest

@testable import TinyKit

internal final class UIListComponentTests: XCTestCase {

    internal final func testRenderComponent() {

        let headerComponent = UIItemComponent(
            contentMode: .size(
                width: 50.0,
                height: 50.0
            ),
            itemView: RectangleView()
        )

        let footerComponent = UIItemComponent(
            contentMode: .size(
                width: 50.0,
                height: 50.0
            ),
            itemView: RectangleView()
        )

        let itemComponents: [Component] = [
            UIItemComponent(
                contentMode: .size(
                    width: 100.0,
                    height: 100.0
                ),
                itemView: RectangleView()
            ),
            UIItemComponent(
                contentMode: .size(
                    width: 200.0,
                    height: 200.0
                ),
                itemView: RectangleView()
            )
        ]
        
        let listComponent = UIListComponent()

        listComponent.headerComponent = headerComponent

        listComponent.footerComponent = footerComponent

        listComponent.itemComponents = UIStubComponentCollection(
            numberOfSections: { return itemComponents.count },
            numberOfItemsInSection: { section in return 1 },
            componentAtItem: { indexPath in itemComponents[indexPath.section] }
        )

        listComponent.render()

        let tableView = listComponent.tableView
        
        let numberOfSections = itemComponents.count

        XCTAssertEqual(
            tableView.tableHeaderView,
            headerComponent.view
        )

        XCTAssertEqual(
            tableView.tableFooterView,
            footerComponent.view
        )

        XCTAssertEqual(
            tableView.numberOfSections,
            numberOfSections
        )

        for section in 0..<numberOfSections {

            XCTAssertEqual(
                tableView.numberOfRows(inSection: section),
                1
            )

            let indexPath = IndexPath(
                item: 0,
                section: section
            )

            let itemComponent = itemComponents[section]
            
            guard
                let cell = itemComponent.view.superview?.superview as? UITableViewCell
            else {
                
                XCTFail("Must be a UITableViewCell.")
                
                return
                    
            }

            XCTAssertEqual(
                tableView.cellForRow(at: indexPath),
                cell
            )

        }

    }

}
