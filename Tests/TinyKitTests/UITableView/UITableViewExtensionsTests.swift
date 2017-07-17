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

class UITableViewExtensionsTests: XCTestCase {

    // MARK: Property

    var tableView: UITableView?

    // MARK: Set Up

    override func setUp() {
        super.setUp()

        tableView = UITableView()

    }

    override func tearDown() {

        tableView = nil

        super.tearDown()
    }

    // MARK: Register Cells

    func testRegisterCellWithoutNib() {

        tableView!.registerCell(
            NoNibTableViewCell.self
        )

        let cell = tableView?.dequeueReusableCell(
            withIdentifier: "NoNibTableViewCell"
        ) as? NoNibTableViewCell

        XCTAssertNotNil(cell)

    }

    func testRegisterCellWithNib() {

        tableView!.registerCell(
            NibTableViewCell.self,
            withNibIn: Bundle(for: classForCoder)
        )

        let cell = tableView?.dequeueReusableCell(
            withIdentifier: "NibTableViewCell"
            ) as? NibTableViewCell

        XCTAssertNotNil(cell)

    }

}
