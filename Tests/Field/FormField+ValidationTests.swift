//
//  FormField+ValidationTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FormField_ValidationTests

import XCTest

@testable import TinyKit

final class FormField_ValidationTests: XCTestCase {
    
    func testDefault() {
        
        let validation = FormField<String>.Validation()
        
        XCTAssertEqual(
            validation.strategy,
            .onlyWhenPresented
        )
        
        XCTAssert(validation.rules.isEmpty)
        
    }
    
    func testInitialization() {
        
        let validation = FormField<String>.Validation(
            strategy: .always,
            rules: [ .nonNull ]
        )
        
        XCTAssertEqual(
            validation.strategy,
            .always
        )
        
        XCTAssertEqual(
            validation.rules.count,
            1
        )
        
    }
    
}
