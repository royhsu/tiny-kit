//
//  OptionalField.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - OptionalField

import TinyCore
import TinyValidation

public final class OptionalField<Value> {
    
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

extension OptionalField {
    
    public func mutateValue(
        _ mutation: @escaping (inout Value?) -> Void
    ) { _storage.mutateValue(mutation) }
    
}

// MARK: - Validation

public extension OptionalField {

    @discardableResult
    public final func validateValueIfPresent() throws -> Value? {

        guard let value = value else { return nil }
        
        try rules.forEach { rule in _ = try rule.validate(value) }
        
        return value

    }

}

// MARK: - Observable

extension OptionalField: Observable {
    
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

// MARK: - Binding

public extension OptionalField {
    
    public typealias BindingDestination = Property<Value>.BindingDestination
    
    public func bind<Target: AnyObject, U>(
        on queue: DispatchQueue = .main,
        transform: @escaping (Value?) -> U,
        to destination: BindingDestination<Target, U>
    )
    -> Observation {
     
        return _storage.bind(
            on: queue,
            transform: transform,
            to: destination
        )
        
    }

    public func bind<Target: AnyObject, U>(
        on queue: DispatchQueue = .main,
        transform: @escaping (Value?) -> U?,
        to destination: BindingDestination<Target, U?>
    )
    -> Observation {
        
        return _storage.bind(
            on: queue,
            transform: transform,
            to: destination
        )
        
    }
    
    public func bind<Target: AnyObject>(
        on queue: DispatchQueue = .main,
        to destination: BindingDestination<Target, Value?>
    )
    -> Observation {
     
        return _storage.bind(
            on: queue,
            to: destination
        )
        
    }
    
}
