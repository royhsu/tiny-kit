//
//  ReusableCellTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ReusableCellTests

import UIKit
import XCTest

internal final class ReusableCellTests: XCTestCase {

    internal final func testIdentifier() {

        XCTAssertEqual(
            ClassTableViewCell.reuseIdentifier,
            "ClassTableViewCell"
        )

    }

    internal final func testNibName() {

        XCTAssertEqual(
            NibTableViewCell.nibName,
            "NibTableViewCell"
        )

    }

}
