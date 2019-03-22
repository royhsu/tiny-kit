//
//  FormFieldTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FormFieldTests

import TinyValidation
import XCTest

@testable import TinyKit

final class FormFieldTests: XCTestCase {
    
    func testDefault() {
        
        let field = FormField<String>()
        
        XCTAssertNil(field.value)
        
        XCTAssertEqual(
            field.validation.strategy,
            .onlyWhenPresented
        )
        
        XCTAssert(field.validation.rules.isEmpty)
        
    }
    
//    func testValidateWithoutRules() {
//
//        let field = RequiredField<String>()
//
//        XCTAssertThrowsError(
//            try field.validateValue()
//        ) { XCTAssert($0 is NonNullError) }
//
//        field.mutateValue { $0 = "valid" }
//
//        XCTAssertEqual(
//            try field.validateValue(),
//            "valid"
//        )
//
//    }
//
//    func testValidateWithRules() {
//
//        let field = RequiredField<String>(
//            rules: [ .nonEmpty ]
//        )
//
//        XCTAssertThrowsError(
//            try field.validateValue()
//        ) { XCTAssert($0 is NonNullError) }
//
//        field.mutateValue { $0 = "" }
//
//        XCTAssertThrowsError(
//            try field.validateValue()
//        ) { XCTAssert($0 is NonEmptyError) }
//
//        field.mutateValue { $0 = "valid" }
//
//        XCTAssertEqual(
//            try field.validateValue(),
//            "valid"
//        )
//
//    }
    
    func testEquality() {
        
        XCTAssertEqual(
            FormField(1),
            FormField(1)
        )
        
        XCTAssertNotEqual(
            FormField(1),
            FormField(2)
        )
        
    }
    
}
