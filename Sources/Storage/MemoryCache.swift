//
//  MemoryCache.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MemoryCache

import TinyCore

public struct MemoryCache<Key, Value>: MutableStorage, Initializable, ExpressibleByDictionaryLiteral where Key: Hashable {
    
    public typealias Storage = Dictionary<Key, Value>
    
    public typealias Element = Storage.Element
    
    public typealias Change = StorageChange<Key, Value>
    
    public typealias Changes = Set<Change>
    
    public typealias Index = Storage.Index
    
    private var _storage: Storage
    
    public init() { self._storage = [:] }
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
     
        self._storage = Storage(uniqueKeysWithValues: elements)
        
        changes.value = Set(
            elements.map(StorageChange.init)
        )
        
    }
    
    public let changes = Observable<Changes>()
    
    private var _isLoaded = false

    public var isLoaded: Bool { return _isLoaded }
    
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
        completion: @escaping (Result<Value>) -> Void
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
    
    public mutating func load() { _isLoaded = true }
    
    public mutating func merge<S>(
        _ other: S,
        options: ObservableValueOptions = []
    )
    where S: Sequence, S.Element == (key: Key, value: Value?) {
        
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
        
        changes.setValue(
            Set(
                updatingElements.map(StorageChange.init)
            ),
            options: options
        )
        
    }
    
}
