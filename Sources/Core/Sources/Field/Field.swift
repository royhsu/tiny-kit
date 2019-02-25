//
//  Field.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Field

import TinyCore
import TinyValidation

public final class Field<Value> {

    private let _storage: Property<Value>

    public var rules: [AnyValidationRule<Value>]

    public var isRequired: Bool

    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {

        self._storage = Property(value: value)

        self.rules = rules

        self.isRequired = isRequired

    }

}

extension Field {
    
    public func mutateValue(
        _ mutation: @escaping (inout Value?) -> Void
    ) { _storage.mutateValue(mutation) }
    
}

// MARK: - Decodable

extension Field: Decodable where Value: Decodable {
    
    public convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        let value = try container.decode(Value.self)
        
        self.init(value: value)
        
    }
    
}

// MARK: - Encodable

extension Field: Encodable where Value: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        let validValue = try validate()
        
        try container.encode(validValue)
        
    }
    
}

// MARK: - Validation

public extension Field {

    @discardableResult
    public final func validate() throws -> Value? {

        return try Field.validateValue(
            value,
            rules: rules,
            isRequired: isRequired
        )

    }

    @discardableResult
    private static func validateValue(
        _ value: Value?,
        rules: [AnyValidationRule<Value>],
        isRequired: Bool
    )
    throws -> Value? {

        if isRequired {

            let value = try value.explicitValidated(
                by: NonNullRule()
            )

            try rules.forEach { rule in _ = try rule.validate(value) }

            return value

        }
        else {

            guard let value = value else { return nil }

            try rules.forEach { rule in _ = try rule.validate(value) }

            return value

        }

    }

}

// MARK: - Observable

extension Field: Observable {
    
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

public extension Field {
    
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
