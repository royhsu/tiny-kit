//
//  XCTUnwrapped.swift
//  TinyTesting
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - XCTUnwrapped

import XCTest

@discardableResult
public func XCTUnwrapped<T>(
    _ optional: T?,
    _ message: @autoclosure () -> String = "The optional value is nil.",
    file: StaticString = #file,
    line: UInt = #line
)
-> T {

    if let unwrapped = optional { return unwrapped }

    fatalError(
        message(),
        file: file,
        line: line
    )

}
