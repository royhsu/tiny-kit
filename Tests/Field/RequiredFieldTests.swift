//
//  RequiredFieldTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/26.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - RequiredFieldTests

import TinyValidation
import XCTest

@testable import TinyKit

final class RequiredFieldTests: XCTestCase {
    
    func testDefault() {
        
        let field = RequiredField<String>()
        
        XCTAssertNil(field.value)
        
        XCTAssert(field.rules.isEmpty)
        
    }
    
    func testValidateWithoutRules() {
        
        let field = RequiredField<String>()
        
        XCTAssertThrowsError(
            try field.validateValue()
        ) { XCTAssert($0 is NonNullError) }
        
        field.mutateValue { $0 = "valid" }
        
        XCTAssertEqual(
            try field.validateValue(),
            "valid"
        )
        
    }
    
    func testValidateWithRules() {
        
        let field = RequiredField<String>(
            rules: [ .nonEmpty ]
        )
        
        XCTAssertThrowsError(
            try field.validateValue()
        ) { XCTAssert($0 is NonNullError) }
        
        field.mutateValue { $0 = "" }
        
        XCTAssertThrowsError(
            try field.validateValue()
        ) { XCTAssert($0 is NonEmptyError) }
        
        field.mutateValue { $0 = "valid" }
        
        XCTAssertEqual(
            try field.validateValue(),
            "valid"
        )
        
    }
    
}
