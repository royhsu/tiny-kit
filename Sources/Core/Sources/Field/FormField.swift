//
//  FormField.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/3/22.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - FormField

import TinyCore
import Foundation

public final class FormField<Value> {
    
    let _storage: Property<Storage>
    
    public var validation = Validation()
    
    public init(_ initialValue: Value? = nil) {
        
        let date = Date()
        
        self._storage = Property(
            value: Storage(
                value: initialValue,
                createdDate: date,
                modifiedDate: date
            )
        )
        
    }
    
}

extension FormField {
    
    public var createdDate: Date { return _storage.value!.createdDate }
    
    public var modifiedDate: Date { return _storage.value!.modifiedDate }
    
    public func modify(_ closure: @escaping (inout Value?) -> () ) {
        
        _storage.mutateValue { storage in
            
            var newValue = storage?.value
            
            closure(&newValue)
            
            storage?.value = newValue
            
            storage?.modifiedDate = Date()
            
        }
        
    }
    
}

// MARK: - Storage

extension FormField {
    
    struct Storage {
        
        var value: Value?
        
        let createdDate: Date
        
        var modifiedDate: Date
        
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
