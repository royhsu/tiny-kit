//
//  Storage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Storage

import TinyCore

public protocol Storage {
    
    associatedtype Key: Hashable, Comparable
    
    associatedtype Value
    
    var keyDiff: Observable< Set<Key> > { get }
    
    var pairs: AnyCollection< (key: Key, value: Value) > { get }
    
    func setPairs(_ pairs: AnyCollection< (key: Key, value: Value?) >)
    
}

public extension Storage where Key == Int {
    
    public func setValues(
        _ values: [Value?]
    ) {
        
        let pairs = values.enumerated().map { ($0.offset, $0.element) }
        
        setPairs(
            AnyCollection(pairs)
        )
        
    }
    
    /// The count of stored pairs.
    public var count: Int { return pairs.count }
    
    public var isEmpty: Bool { return pairs.isEmpty }
    
    public subscript(key: Key) -> Value? {
        
        get { return pairs.first { $0.key == key }?.value }
        
        set {
            
            setPairs(
                AnyCollection(
                    [
                        (key, newValue)
                    ]
                )
            )
            
        }
        
    }
    
}

// MARK: - AnyStorage

public struct AnyStorage<Key, Value>: Storage
where Key: Hashable & Comparable {
    
    private let _keyDiff: () -> Observable< Set<Key> >
    
    private let _pairs: () -> AnyCollection< (key: Key, value: Value) >
    
    private let _setPairs: (AnyCollection< (key: Key, value: Value?) >) -> Void

    public init<S: Storage>(_ storage: S)
    where
        S.Key == Key,
        S.Value == Value {

        self._keyDiff = { storage.keyDiff }
            
        self._pairs = { storage.pairs }
            
        self._setPairs = storage.setPairs
            
    }
    
    // MARK: Storage
    
    public var keyDiff: Observable< Set<Key> > { return _keyDiff() }
    
    public var pairs: AnyCollection< (key:Key, value: Value) > { return _pairs() }
    
    public func setPairs(
        _ pairs: AnyCollection< (key: Key, value: Value?) >
    ) { _setPairs(pairs) }
    
}
