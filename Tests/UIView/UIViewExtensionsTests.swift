//
//  UIViewExtensionsTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - UIViewExtensionsTests

import XCTest

@testable import TinyKit

class UIViewExtensionsTests: XCTestCase {

    // MARK: Load Views From Nibs

    func testLoadViewFromNib() {

        let view: NibTableViewCell? = UIView.load(
            from: Bundle(for: classForCoder)
        )

        XCTAssertNotNil(view)

    }

}
