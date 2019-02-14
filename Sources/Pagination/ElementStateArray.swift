//
//  ElementStateArray.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/14.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - ElementStateArray

#warning("TODO: add testing.")
public struct ElementStateArray<Element> {
    
    private var _states: [ElementState<Element>]
    
    var willGetElement: (
        (
            _ array: ElementStateArray,
            _ index: Int
        )
        -> Void
    )?
    
    public init<S>(_ sequence: S)
    where
        S: Sequence,
        S.Element == ElementState<Element> { self._states = Array(sequence) }
    
}

// MARK: - Collection

extension ElementStateArray: Collection {
    
    public var startIndex: Int { return _states.startIndex }
    
    public var endIndex: Int { return _states.endIndex }
    
    public func index(after i: Int) -> Int { return _states.index(after: i) }
    
    public subscript(index: Int) -> ElementState<Element> {
        
        willGetElement?(
            self,
            index
        )
        
        return _states[index]
        
    }
    
}

// MARK: - Equatable

extension ElementStateArray: Equatable where Element: Equatable {
    
    public static func == (
        lhs: ElementStateArray,
        rhs: ElementStateArray
    )
    -> Bool { return lhs._states == rhs._states }
    
}

// MARK: - ExpressibleByArrayLiteral

extension ElementStateArray: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral states: ElementState<Element>...) { self.init(states) }
    
}
