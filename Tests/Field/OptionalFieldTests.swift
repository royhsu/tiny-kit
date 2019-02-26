//
//  OptionalFieldTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/12/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - OptionalFieldTests

import TinyValidation
import XCTest

@testable import TinyKit

final class OptionalFieldTests: XCTestCase {

    func testDefault() {

        let field = OptionalField<String>()

        XCTAssertNil(field.value)

        XCTAssert(field.rules.isEmpty)

    }
    
    func testValidateWillSkipRulesWhenNoValuePresented() {
        
        let field = OptionalField<String>()
        
        XCTAssertNoThrow(
            try field.validateValueIfPresent()
        )
        
        XCTAssertEqual(
            try field.validateValueIfPresent(),
            nil
        )
        
    }
    
    func testValidateWithRulesWhenValuePresented() {
        
        let field = OptionalField<String>(
            rules: [ .nonEmpty ]
        )
        
        field.mutateValue { $0 = "" }
        
        XCTAssertThrowsError(
            try field.validateValueIfPresent()
        ) { XCTAssert($0 is NonEmptyError) }
        
        field.mutateValue { $0 = "valid" }
        
        XCTAssertEqual(
            try field.validateValueIfPresent(),
            "valid"
        )
        
    }
    
}
