//
//  Observable.swift
//  TinyStore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Observable

public final class Observable<T> {
    
    public private(set) final var value: T {
        
        didSet { didChangeValueHandler?(oldValue, value) }
        
    }
    
    public typealias DidChangeValueHandler = (
        _ oldValue: T,
        _ newValue: T
    )
    -> Void
    
    private final var didChangeValueHandler: DidChangeValueHandler?
    
    public init(_ value: T) { self.value = value }
    
}

extension Observable {
    
    @discardableResult
    public final func onDidChangeValue(handler: DidChangeValueHandler? = nil) -> Self {
        
        didChangeValueHandler = handler
        
        return self
        
    }
    
}

extension Observable {
    
    public final func input(_ newValue: T) { value = newValue }
    
    public final func input<V: Validator>(
        _ newValue: T,
        validator: V
    )
    throws -> Void
    where V.T == T {
        
        let result = validator.validate(value: newValue)
        
        switch result {
            
        case .success(let validValue): value = validValue
            
        case .failure(let error): throw error
            
        }
            
    }
    
}
