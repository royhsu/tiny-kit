//
//  FormField+CodableTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FormField_CodableTests

import TinyValidation
import XCTest

@testable import TinyKit

final class FormField_CodableTests: XCTestCase {
    
    func testDecode() throws {
        
        let data = try JSONSerialization.data(withJSONObject: [ 1 ])
        
        XCTAssertEqual(
            try JSONDecoder().decode([FormField<Int>].self, from: data),
            [ FormField(1) ]
        )
        
    }
    
    func testEncode() {
        
        let field = FormField("")
        
        field.validation.rules = [ .nonEmpty ]
        
        XCTAssertThrowsError(
            try JSONEncoder().encode(field)
        ) { XCTAssert($0 is NonEmptyError) }
        
        field.value = "new value"
        
        XCTAssertEqual(
            try JSONEncoder().encode([ field ]),
            try JSONSerialization.data(withJSONObject: [ "new value" ])
        )
        
    }
    
}
