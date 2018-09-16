//
//  MemoryCache.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MemoryCache

public struct MemoryCache<Key, Value>: Storage
where Key: Hashable & Comparable {
    
    public typealias KeyValuePairs = [Key: Value]
    
    fileprivate var _storage: KeyValuePairs = [:]
    
    public let keyDiff = KeyDiff()
    
    public init() { }
    
    public var maxKey: Key? { return _storage.keys.max() }
    
    public func value(forKey key: Key) -> Value? {
        
        return _storage[key]
        
    }
    
    public mutating func setValue(
        _ value: Value,
        forKey key: Key
    ) {
        
        _storage[key] = value
        
        keyDiff.value = [ key ]
        
    }
    
    // TODO: add unit test.
    public mutating func setKeyValuePairs(
        _ pairs: KeyValuePairs
    ) {
        
        _storage = pairs
        
        keyDiff.value = pairs.map { $0.key }
        
    }
    
}

public extension MemoryCache where Key == Int {
    
    // TODO: add unit test.
    public mutating func setValues(
        _ values: [Value]
    ) {
        
        let keyValuePairs = values.enumerated().map { ($0.offset, $0.element) }
        
        let dictionary = Dictionary(
            keyValuePairs,
            uniquingKeysWith: { first, _ in first }
        )
        
        setKeyValuePairs(dictionary)
        
    }
 
}
