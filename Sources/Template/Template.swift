//
//  Template.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Template

public protocol Template {
    
    associatedtype Element
    
    associatedtype Storage
    
    var storage: Storage { get }
    
    var numberOfElements: Int { get }
    
    func view(at index: Int) -> View
    
}

// MARK: - AnyTemplate

public struct AnyTemplate<Element, Storage>: Template {
    
    private let _storage: () -> Storage
    
    private let _numberOfElements: () -> Int
    
    private let _view: (_ index: Int) -> View
    
    public init<T>(_ template: T)
    where
        T: Template,
        T.Element == Element,
        T.Storage == Storage {
            
        self._storage = { template.storage }
            
        self._numberOfElements = { template.numberOfElements }
            
        self._view = template.view
            
    }
    
    public var storage: Storage { return _storage() }
    
    public var numberOfElements: Int { return _numberOfElements() }
    
    public func view(at index: Int) -> View { return _view(index) }
    
}
