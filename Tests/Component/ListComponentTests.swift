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

    internal final var itemComponents: [Component] = []

    internal final override func setUp() {

        super.setUp()

        itemComponents = [
            ItemComponent(
                contentMode: .size(
                    width: 100.0,
                    height: 100.0
                ),
                itemView: RectangleView()
            ),
            ItemComponent(
                contentMode: .size(
                    width: 200.0,
                    height: 200.0
                ),
                itemView: RectangleView()
            )
        ]

    }

    internal final override func tearDown() {

        itemComponents = []

        super.tearDown()

    }

    internal final func testRenderListComponent() {

        let headerComponent = ItemComponent(
            contentMode: .size(
                width: 50.0,
                height: 50.0
            ),
            itemView: RectangleView()
        )

        let footerComponent = ItemComponent(
            contentMode: .size(
                width: 50.0,
                height: 50.0
            ),
            itemView: RectangleView()
        )

        let listComponent = UIListComponent()

        listComponent.headerComponent = headerComponent

        listComponent.footerComponent = footerComponent

        listComponent.itemComponents = self

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
            numberOfSections()
        )

        for section in 0..<numberOfSections() {

            for item in 0..<numberOfItemsAtSection(section) {

                let indexPath = IndexPath(
                    item: item,
                    section: section
                )

                XCTAssertEqual(
                    tableView.numberOfRows(inSection: section),
                    numberOfItemsAtSection(section)
                )

                let component = componentForItem(at: indexPath)

                XCTAssertEqual(
                    tableView.cellForRow(at: indexPath),
                    component.view.superview?.superview
                )

            }

        }

    }

}

// MARK: - ListComponentDataSource

extension ListComponentTests: ListItemComponents {

    internal final func numberOfSections() -> Int { return itemComponents.count }

    internal final func numberOfItemsAtSection(_ section: Int) -> Int { return 1 }

    internal final func componentForItem(at indexPath: IndexPath) -> Component { return itemComponents[indexPath.section] }

}
