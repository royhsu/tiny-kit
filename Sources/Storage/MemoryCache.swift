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
    public final func setPairs(_ pairs: AnyCollection< (key: Key, value: Value?) >) {
        
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
        
        keyDiff.value = changingKeys
        
    }
    
}
