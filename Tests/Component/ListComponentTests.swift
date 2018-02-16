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

        let item1Component = ItemComponent(
            contentMode: .size(
                width: 100.0,
                height: 100.0
            ),
            itemView: RectangleView()
        )

        let item2Component = ItemComponent(
            contentMode: .size(
                width: 200.0,
                height: 200.0
            ),
            itemView: RectangleView()
        )

        let itemComponents: [Component] = [
            item1Component,
            item2Component
        ]

        let listComponent = ListComponent()

        listComponent.itemComponents = AnyCollection(itemComponents)

        listComponent.render()

        XCTAssertEqual(
            listComponent.view as? UITableView,
            listComponent.tableView
        )

        XCTAssertEqual(
            listComponent.tableView.numberOfSections,
            Int(listComponent.itemComponents.count)
        )

        guard
            let item1Section = itemComponents.index(
                where: { $0 as? ItemComponent<RectangleView> === item1Component }
            )
        else {

            XCTFail("There should be a section for the item 1 component.")

            return

        }

        XCTAssertEqual(
            listComponent.tableView.numberOfRows(inSection: item1Section),
            1
        )

        let item1Cell = listComponent.tableView.cellForRow(
            at: IndexPath(
                row: 0,
                section: item1Section
            )
        )

        XCTAssertNotNil(item1Cell)

        guard
            let item2Section = itemComponents.index(
                where: { $0 as? ItemComponent<RectangleView> === item2Component }
            )
        else {

            XCTFail("There should be a section for the item 2 component.")

            return

        }

        XCTAssertEqual(
            listComponent.tableView.numberOfRows(inSection: item2Section),
            1
        )

        let item2Cell = listComponent.tableView.cellForRow(
            at: IndexPath(
                row: 0,
                section: item2Section
            )
        )

        XCTAssertNotNil(item2Cell)

        XCTAssertEqual(
            listComponent.preferredContentSize,
            listComponent.tableView.contentSize
        )

    }

}
