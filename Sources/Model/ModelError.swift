//
//  ModelError.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MAKR: - ModelError

public struct ModelError<Value>: Error {
    
    public let currentValue: Value?
    
    public let errors: [Error]
    
    public init(
        currentValue: Value?,
        errors: [Error]
    ) {
        
        self.currentValue = currentValue
        
        self.errors = errors
        
    }
    
}
