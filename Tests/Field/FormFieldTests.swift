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
        
    }
    
    func testAlwaysValidateValue() {
        
        let field = FormField<String>()
        
        field.validation.rules = [ .nonNull ]
        
        field.validation.strategy = .always
        
        XCTAssertThrowsError(
            try field.validateIfNeeded()
        ) { XCTAssert($0 is NonNullError) }
        
        field.value = "new value"
        
        XCTAssertEqual(
            try field.validateIfNeeded(),
            "new value"
        )
        
    }
    
    func testValidateOnlyWhenValuePresented() {
        
        let field = FormField<String>()
        
        field.validation.rules = [ .nonEmpty ]
        
        XCTAssertNoThrow( try field.validateIfNeeded() )
        
        field.value = ""
        
        XCTAssertThrowsError(
            try field.validateIfNeeded()
        ) { XCTAssert($0 is NonEmptyError) }
        
        field.value = "new value"
        
        XCTAssertEqual(
            try field.validateIfNeeded(),
            "new value"
        )
        
    }
    
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
