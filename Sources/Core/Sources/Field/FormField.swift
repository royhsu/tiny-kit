//
//  FormField.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FormField

import TinyCore

public final class FormField<Value> {
    
    let _storage: Property<Value>
    
    public var validation = Validation()
    
    public init(_ initialValue: Value? = nil) {
        
        self._storage = Property(value: initialValue)
        
    }
    
}

extension FormField {
    
    public func modify(_ closure: @escaping (inout Value?) -> () ) {
        
        _storage.mutateValue(closure)
        
    }
    
}

// MARK: - Equatable

extension FormField: Equatable where Value: Equatable {
    
    public static func == (
        lhs: FormField,
        rhs: FormField
    )
    -> Bool { return lhs.value == rhs.value }
    
}
