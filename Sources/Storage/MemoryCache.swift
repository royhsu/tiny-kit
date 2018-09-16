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
    
    public final let keyDiff = Observable<[Key]>()
    
    public init() { }
    
    public final var pairs: AnyCollection<(key: Key, value: Value)> {
        
        return AnyCollection(
            _storage.lazy.elements
        )

    }
    
    // TODO: add unit test.
    public final func setPairs(_ pairs: AnyCollection<(key: Key, value: Value)>) {
        
        let pairs = pairs.map { (key: $0, value: $1) }
        
        _storage = Dictionary(
            pairs,
            uniquingKeysWith: { first, _ in first }
        )
        
        keyDiff.value = pairs.map { $0.key }
        
    }
    
}
