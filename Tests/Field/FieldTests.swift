//
//  FieldTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/12/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - FieldTests

import TinyValidation
import XCTest

@testable import TinyKit

final class FieldTests: XCTestCase {

    func testDefault() {

        let field = Field<String>()

        XCTAssertNil(field.value)

        XCTAssert(field.rules.isEmpty)

        XCTAssert(field.isRequired)

    }

    func testRequiredWhenValidate() {

        let field = Field<String>()

        XCTAssertThrowsError(
            try field.validate()
        ) { XCTAssert($0 is NonNullError) }

        field.mutateValue { $0 = "valid" }
        
        XCTAssertEqual(
            try field.validate(),
            "valid"
        )

    }
    
    func testRequiredWhenValidateWithRules() {
        
        let field = Field<String>(
            rules: [ .nonEmpty ]
        )
        
        XCTAssertThrowsError(
            try field.validate()
        ) { XCTAssert($0 is NonNullError) }
        
        field.mutateValue { $0 = "" }
        
        XCTAssertThrowsError(
            try field.validate()
        ) { XCTAssert($0 is NonEmptyError) }
        
        field.mutateValue { $0 = "valid" }
        
        XCTAssertEqual(
            try field.validate(),
            "valid"
        )
        
    }
    
    func testNotRequiredWillSkipToValidate() {
        
        let field = Field<String>(isRequired: false)
        
        XCTAssertEqual(
            try field.validate(),
            nil
        )
        
    }
    
    func testNotRequiredButIfDoesContainValueThenWillValidateWithRules() {
        
        let field = Field<String>(
            rules: [ .nonEmpty ],
            isRequired: false
        )
        
        XCTAssertNoThrow(
            try field.validate()
        )
        
        field.mutateValue { $0 = "" }
        
        XCTAssertThrowsError(
            try field.validate()
        ) { XCTAssert($0 is NonEmptyError) }
        
        field.mutateValue { $0 = "valid" }
        
        XCTAssertEqual(
            try field.validate(),
            "valid"
        )
        
    }
    
}
