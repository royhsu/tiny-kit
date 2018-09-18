//
//  MemoryCache.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MemoryCache

import TinyCore

public final class MemoryCache<Key, Value>: Storage
where Key: Hashable & Comparable {
    
    private final var _storage: [Key: Value] = [:]
    
    public final let keyDiff = Observable< Set<Key> >()
    
    public init() { }
    
    public final var pairs: AnyCollection< (key: Key, value: Value) > { return AnyCollection(_storage.lazy) }
    
    /// Only accepting the first value for a key and ignoring the rest of values for the same key.
    /// The keyDiff will also notify changes including keys are set to nil.
    public final func setPairs(
        _ pairs: AnyCollection< (key: Key, value: Value?) >,
        options: ObservableValueOptions? = nil
    ) {
        
        // Finding the keys contain existing values.
        let existingValueKeys = pairs
            .map { $0.key }
            .filter { self._storage[$0] != nil }
        
        var changingKeys = Set(existingValueKeys)
        
        // Filtering out the updating pairs which must contain values.
        let updatingPairs: [(key: Key, value: Value)] = pairs
            .map { pair -> (Key, Value)? in
            
                let key = pair.key
                
                if let value = pair.value {
                    
                    changingKeys.insert(key)
                    
                    return (key, value)
                    
                }
                
                return nil
                
            }
            .compactMap { $0 }

        _storage = Dictionary(
            updatingPairs,
            uniquingKeysWith: { first, _ in first }
        )
        
        keyDiff.setValue(
            changingKeys,
            options: options
        )
        
    }
    
    public func removeAll(options: ObservableValueOptions? = nil) {
        
        let removingKeys = Set(_storage.keys)
        
        _storage = [:]
        
        keyDiff.setValue(
            removingKeys,
            options: options
        )
        
    }
    
}

public struct NewMemoryCache<Key, Value>: MutableStorage
where Key: Hashable {
    
    public typealias Storage = Dictionary<Key, Value>
    
    public typealias Element = Storage.Element
    
    public typealias Index = Storage.Index
    
    private var _storage = Storage()
    
    public var startIndex: Index { return _storage.startIndex }
    
    public var endIndex: Index { return _storage.endIndex }
    
    public func index(after i: Index) -> Index { return _storage.index(after: i) }
    
    public subscript(key: Key) -> Value? {
        
        get { return _storage[key] }
     
        set { _storage[key] = newValue }
        
    }
    
    public subscript(position: Index) -> Element { return _storage[position] }
    
}
