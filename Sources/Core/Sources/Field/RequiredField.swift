//
//  RequiredField.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/26.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - RequiredField

import TinyCore
import TinyValidation

public final class RequiredField<Value> {
    
    private let _storage: Property<Value>
    
    public var rules: [AnyValidationRule<Value>]
    
    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = []
    ) {
        
        self._storage = Property(value: value)
        
        self.rules = rules
        
    }
    
}

extension RequiredField {
    
    public func mutateValue(
        _ mutation: @escaping (inout Value?) -> Void
    ) { _storage.mutateValue(mutation) }
    
}

// MARK: - Validation

public extension RequiredField {
    
    @discardableResult
    public final func validateValue() throws -> Value {
        
        let value = try self.value.explicitValidated(
            by: NonNullRule()
        )
        
        try rules.forEach { rule in _ = try rule.validate(value) }
        
        return value
        
    }
    
}

// MARK: - Observable

extension RequiredField: Observable {
    
    public var value: Value? { return _storage.value }
    
    public func observe(
        on queue: DispatchQueue = .global(),
        observer: @escaping (Property<Value>.ObservedChange) -> Void
    )
    -> Observation {
        
        return _storage.observe(
            on: queue,
            observer: observer
        )
        
    }
    
}
