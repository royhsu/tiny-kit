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
    
    let _storage: Property<Value>
    
    public var validation = Validation()
    
    public init(_ initialValue: Value? = nil) {
        
        self._storage = Property(initialValue)
        
    }
    
}

extension FormField {
    
    public var value: Value? {
        
        get { return _storage.value }
        
        set { modify { $0 = newValue } }
        
    }
    
    public var createdDate: Date { return _storage.createdDate }
    
    public var modifiedDate: Date { return _storage.modifiedDate }
    
    public var isModified: Bool { return modifiedDate > createdDate }
    
    public func modify(_ closure: @escaping (inout Value?) -> Void) {
        
        _storage.modify(closure)
        
    }
    
}

// MARK: - Equatable

extension FormField: Equatable where Value: Equatable {
    
    public static func == (lhs: FormField, rhs: FormField) -> Bool {

        return lhs.value == rhs.value

    }

}
