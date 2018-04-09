//
//  Validator.swift
//  TinyCore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Validator

import TinyCore

public protocol Validator {

    associatedtype T

    func validate(value: Any) -> Result<T>

}
