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

        let sections = 1

        listComponent.headerComponent = headerComponent

        listComponent.footerComponent = footerComponent

        listComponent.setItemComponents(itemComponents)

        listComponent.render()

        let tableView = listComponent.tableView

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
            sections
        )

        for section in 0..<sections {

            let rows =  tableView.numberOfRows(inSection: section)

            for row in 0..<rows {

                let indexPath = IndexPath(
                    row: row,
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

}
