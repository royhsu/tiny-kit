//
//  Model.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Model

public final class Model<Value> {

    private final var storage: Observable<Value>

    public final var value: Value? {

        get { return storage.value }

        set { storage.value = newValue }

    }

    public final var rules: [AnyValidationRule<Value>]

    public final var isRequired: Bool

    public init(
        value: Value? = nil,
        rules: [AnyValidationRule<Value>] = [],
        isRequired: Bool = true
    ) {

        self.storage = Observable(value)

        self.rules = rules

        self.isRequired = isRequired

    }

}

// MARK: - Validation

public extension Model {

    @discardableResult
    public final func validate() throws -> Value? {

        return try Model.validateValue(
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

public extension Model {
    
    public final func observe(
        on queue: DispatchQueue = .main,
        resultHandler: @escaping (Result<Value?>) -> Void
    )
    -> Observation {

        return storage.observe(on: queue) { change in
            
            let currentValue = change.currentValue
            
            do {
            
                let value = try Model.validateValue(
                    currentValue,
                    rules: self.rules,
                    isRequired: self.isRequired
                )
                
                resultHandler(
                    .success(value)
                )
            
            }
            catch {
                
                resultHandler(
                    .failure(
                        ModelError(
                            currentValue: currentValue,
                            errors: [ error ]
                        )
                    )
                )
                
            }

        }

    }
    
    public final func bind<Target: AnyObject, U>(
        transform: @escaping (Value?) -> U,
        on queue: DispatchQueue = .main,
        to target: Target,
        keyPath: ReferenceWritableKeyPath<Target, U>
    ) {
        
        storage.bind(
            transform: transform,
            on: queue,
            to: target,
            keyPath: keyPath
        )
        
    }
    
    public final func bind<Target: AnyObject, U>(
        transform: @escaping (Value?) -> U?,
        on queue: DispatchQueue = .main,
        to target: Target,
        keyPath: ReferenceWritableKeyPath<Target, U?>
    ) {
        
        storage.bind(
            transform: transform,
            on: queue,
            to: target,
            keyPath: keyPath
        )
        
    }
    
    public final func bind<Target: AnyObject>(
        on queue: DispatchQueue = .main,
        to target: Target,
        keyPath: ReferenceWritableKeyPath<Target, Value?>
    ) {
        
        storage.bind(
            on: queue,
            to: target,
            keyPath: keyPath
        )
        
    }

}
