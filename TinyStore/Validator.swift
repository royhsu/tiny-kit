//
//  Validator.swift
//  TinyStore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Validator

public protocol Validator {
    
    associatedtype T
    
    func validate(value: T) -> Result<T>
    
}
