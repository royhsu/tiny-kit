//
//  ReusableCellTests.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ReusableCellTests

import XCTest

internal final class ReusableCellTests: XCTestCase {
    
    internal final func testIdentifier() {
        
        XCTAssertEqual(
            SimpleTableViewCell.identifier,
            "SimpleTableViewCell"
        )
        
    }
    
    internal final func testNibName() {
        
        XCTAssertEqual(
            NibTableViewCell.nibName,
            "NibTableViewCell"
        )
        
    }
    
}
