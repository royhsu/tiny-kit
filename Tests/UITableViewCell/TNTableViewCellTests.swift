//
//  TNTableViewCellTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - TNTableViewCellTests

import XCTest

@testable import TinyKit

class TNTableViewCellTests: XCTestCase {

    // MARK: Init

    func testInitWithComponentViewFactory() {

        let cell = TNTableViewCell<LabelComponentViewFactory>(
            style: .default,
            reuseIdentifier: "TNTableViewCell<LabelComponentViewFactory>"
        )

        XCTAssertEqual(
            cell.reuseIdentifier,
            "TNTableViewCell<LabelComponentViewFactory>"
        )

        cell.frame = CGRect(x: 10.0, y: 10.0, width: 50.0, height: 50.0)

        let componentView = cell.componentView

        cell.layoutIfNeeded()

        XCTAssertEqual(
            componentView.frame,
            cell.contentView.bounds
        )

    }

}
