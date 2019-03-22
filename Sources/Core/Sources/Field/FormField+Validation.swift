//
//  FormField+Validation.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Validation

import TinyValidation

extension FormField {
    
    /// The form field will only validate its value depending on which validation
    /// strategy being specified. See `FormField.Validation.Strategy` for details.
    @discardableResult
    public func validateIfNeeded() throws -> Value? {
        
        let shouldValidate: Bool
        
        switch validation.strategy {
            
        case .always: shouldValidate = true
            
        case .onlyWhenPresented: shouldValidate = (value != nil)
        
        }
        
        for rule in validation.rules where shouldValidate {
            
            try rule.validate(value)
            
        }
        
        return value
        
    }
    
}

extension FormField {
    
    public struct Validation {
        
        public var strategy: Strategy
        
        public var rules: [AnyValidationRule<Value>]
        
        public init(
            strategy: Strategy = .onlyWhenPresented,
            rules: [AnyValidationRule<Value>] = []
        ) {
            
            self.strategy = strategy
            
            self.rules = rules
            
        }
        
    }
    
}

// MARK: - Strategy

extension FormField.Validation {
    
    public enum Strategy {
        
        /// Indicates to always validate the value with rules even it is nil.
        case always
        
        /// Indicates to validate the value with rules only when it's not nil.
        case onlyWhenPresented
        
    }
    
}
