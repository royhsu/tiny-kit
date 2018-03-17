//
//  WeakObject.swift
//  TinyStore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// Reference: https://marcosantadev.com/swift-arrays-holding-elements-weak-references/

// MARK: - WeakObject

public final class WeakObject<T: AnyObject> {
    
    public private(set) final weak var reference: T?
    
    public init(_ reference: T) { self.reference = reference }
    
}
