//
//  UITableViewExtensionsTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - UITableViewExtensionsTests

import UIKit
import XCTest

@testable import TinyKit

final class UITableViewExtensionsTests: XCTestCase {

    // MARK: Component

    enum Component: Int {

        case noNibCell

        case nibCell

    }

    // MARK: Property

    final var components: [Component]?

    final var tableView: UITableView?

    // MARK: Set Up

    final override func setUp() {
        super.setUp()

        components = [ .noNibCell, .nibCell ]

        tableView = UITableView()

        tableView!.dataSource = self

    }

    final override func tearDown() {

        components = nil

        tableView = nil

        super.tearDown()
    }

    // MARK: Register Cells

    final func testRegisterCellWithoutNib() {

        tableView!.registerCell(
            NoNibTableViewCell.self
        )

        let index = components!.index(of: .noNibCell)!

        let section = components![index].rawValue

        let cell = tableView!.dequeueReusableCell(
            withIdentifier: "NoNibTableViewCell",
            for: IndexPath(item: 0, section: section)
        ) as? NoNibTableViewCell

        XCTAssertNotNil(cell)

    }

    final func testRegisterCellWithNib() {

        tableView!.registerCell(
            NibTableViewCell.self,
            withNibFrom: Bundle(for: classForCoder)
        )

        let index = components!.index(of: .nibCell)!

        let section = components![index].rawValue

        let cell = tableView!.dequeueReusableCell(
            withIdentifier: "NibTableViewCell",
            for: IndexPath(item: 0, section: section)
        ) as? NibTableViewCell

        XCTAssertNotNil(cell)

    }

    // MARK: Dequeue Reusable Cells

    final func testDequeueReusableCell() {

        tableView!.registerCell(
            NoNibTableViewCell.self
        )

        let index = components!.index(of: .nibCell)!

        let section = components![index].rawValue

        let cell = tableView!.dequeueReusableCell(
            NoNibTableViewCell.self,
            for: IndexPath(item: 0, section: section)
        )

        XCTAssertNotNil(cell)

    }

}

// MARK: - UITableViewDataSource

extension UITableViewExtensionsTests: UITableViewDataSource {

    final func numberOfSections(in tableView: UITableView) -> Int {

        return components!.count

    }

    final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let component = Component(rawValue: indexPath.section)!

        switch component {

        case .noNibCell:

            let identifier = NoNibTableViewCell.identifier

            return tableView.dequeueReusableCell(
                withIdentifier: identifier,
                for: indexPath
            )

        case .nibCell:

            let identifier = NibTableViewCell.identifier

            return tableView.dequeueReusableCell(
                withIdentifier: identifier,
                for: indexPath
            )

        }

    }

}
