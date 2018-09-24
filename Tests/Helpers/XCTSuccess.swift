//
//  XCTSuccess.swift
//  TinyTesting
//
//  Created by Roy Hsu on 2018/9/9.
//

// MARK: - XCTSuccess

import XCTest

public func XCTSuccess(
    _ message: @autoclosure () -> String = "The successful assertion.",
    file: StaticString = #file,
    line: UInt = #line
) {

    XCTAssertTrue(
        true,
        message,
        file: file,
        line: line
    )

}
