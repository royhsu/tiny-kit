//
//  MemoryCache.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MemoryCache

public final class MemoryCache<Key, Value>: Storage
where
    Key: Hashable,
    Key: Comparable {
    
    public typealias KeyValuePairs = [Key: Value]
    
    private var _storage: KeyValuePairs = [:]
    
    public init() { }
    
    // MARK: Storage
    
    public final let keyDiff = KeyDiff()
    
    public var maxKey: Key? { return _storage.keys.max() }

    public subscript(_ key: Key) -> Value? {
        
        get { return _storage[key] }
        
        set {
            
            _storage[key] = newValue
            
            keyDiff.value = [ key ]
            
        }
        
    }
    
}

public extension MemoryCache {
    
    public final func setKeyValuePairs(
        _ pairs: KeyValuePairs
    ) {
        
        _storage = pairs
        
        keyDiff.value = pairs.map { $0.key }
        
    }
    
}