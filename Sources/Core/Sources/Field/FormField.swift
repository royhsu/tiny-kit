//
//  FormField.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FormField

import TinyCore
import TinyValidation

public final class FormField<Value> {
    
    private let _storage: Property<Value>
    
    public var validation = Validation()
    
    public init(_ initialValue: Value? = nil) {
        
        self._storage = Property(value: initialValue)
        
    }
    
}

extension FormField {
    
    public var value: Value? { return _storage.value }
    
}

// MARK: - Equatable

extension FormField: Equatable where Value: Equatable {
    
    public static func == (
        lhs: FormField,
        rhs: FormField
    )
    -> Bool { return lhs.value == rhs.value }
    
}

// MARK: - Validation

extension FormField {
    
    public struct Validation {
        
        public var strategy: ValidationStrategy
        
        public var rules: [AnyValidationRule<Value>]
        
        public init(
            strategy: ValidationStrategy = .onlyWhenPresented,
            rules: [AnyValidationRule<Value>] = []
        ) {
            
            self.strategy = strategy
            
            self.rules = rules
            
        }
        
    }
    
}

// MARK: - ValidationStrategy

extension FormField {

    public enum ValidationStrategy {
        
        /// Indicates to always validate the value with rules even it is nil.
        case always
        
        /// Indicates to validate the value with rules only when it's not nil.
        case onlyWhenPresented
        
    }

}
