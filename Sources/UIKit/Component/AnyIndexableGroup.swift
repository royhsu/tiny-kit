//
//  AnyIndexableGroup.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnyIndexableGroup

public struct AnyIndexableGroup<T>: IndexableGroup {
    
    private let _numberOfSections:  Int
    
    private let _numberOfElementsHandler: (_ section: Int) -> Int
    
    private let _elementHandler: (_ indexPath: IndexPath) -> T
    
    public init<G: IndexableGroup>(_ base: G) where G.Element == T {
        
        self._numberOfSections = base.numberOfSections
        
        self._numberOfElementsHandler = base.numberOfElements
        
        self._elementHandler = base.element
        
    }
    
    // MARK: IndexableGroup
    
    public var numberOfSections: Int { return _numberOfSections }
    
    public func numberOfElements(inSection section: Int) -> Int { return _numberOfElementsHandler(section) }
    
    public func element(at indexPath: IndexPath) -> T { return _elementHandler(indexPath) }
    
}
