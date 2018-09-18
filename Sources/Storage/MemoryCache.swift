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

public struct NewMemoryCache<Key, Value>: MutableStorage, ExpressibleByDictionaryLiteral where Key: Hashable {
    
    public typealias Storage = Dictionary<Key, Value>
    
    public typealias Element = Storage.Element
    
    public typealias Change = StorageChange<Key, Value>
    
    public typealias Changes = Set<Change>
    
    public typealias Index = Storage.Index
    
    private var _storage: Storage
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
     
        self._storage = Storage(uniqueKeysWithValues: elements)
        
        changes.value = Set(
            elements.map(StorageChange.init)
        )
        
    }
    
    public let changes = Observable<Changes>()
    
    public var startIndex: Index { return _storage.startIndex }
    
    public var endIndex: Index { return _storage.endIndex }
    
    public func index(after i: Index) -> Index { return _storage.index(after: i) }
    
    public subscript(key: Key) -> Value? {
        
        get { return _storage[key] }
     
        set {
            
            _storage[key] = newValue
            
            changes.value = [
                Change(
                    key: key,
                    value: newValue
                )
            ]
            
        }
        
    }
    
    public subscript(position: Index) -> Element { return _storage[position] }
    
    public func value(
        forKey key: Key,
        completion: (Result<Value>) -> Void
    ) {
        
        guard
            let value = self[key]
        else {
            
            let error: StorageError<Key> = .valueNotFound(key: key)
            
            return completion(
                .failure(error)
            )
            
        }
        
        completion(
            .success(value)
        )
        
    }
    
    public mutating func merge<S>(_ other: S)
    where
        S: Sequence,
        S.Element == (key: Key, value: Value?) {
        
        var mergingElements: [ (Key, Value) ] = []
        
        var removingKeys: [Key] = []
            
        var updatingElements: [ (key: Key, value: Value) ] = []
        
        for element in other {
            
            let key = element.key
            
            if let newValue = element.value {
                
                mergingElements.append(
                    (key, newValue)
                )
                
                updatingElements.append(
                    (key, newValue)
                )
                
            }
            else {
                
                if let existingValue = self[key] {
                    
                    updatingElements.append(
                        (key, existingValue)
                    )
                    
                }
                else { removingKeys.append(key) }
                
            }
            
        }
        
        removingKeys.forEach { self._storage.removeValue(forKey: $0) }

        _storage.merge(
            mergingElements,
            uniquingKeysWith: { _, new in new }
        )
        
        changes.value = Set(
            updatingElements.map(StorageChange.init)
        )
        
    }
    
}
