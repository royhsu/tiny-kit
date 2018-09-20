//
//  MutableStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/19.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MutableStorage

import TinyCore

public protocol MutableStorage: Storage {
    
    #warning("Testing required for all concrete types")
    var isLoaded: Bool { get }
    
    func load()
    
    func setValue(
        _ value: Value?,
        forKey key: Key,
        options: ObservableValueOptions
    )
    
    func merge(
        _ other: AnySequence< (key: Key, value: Value?) >,
        options: ObservableValueOptions
    )
    
}

public extension MutableStorage {
    
    subscript(key: Key) -> Value? {
        
        get { return value(forKey: key) }
        
        set {
            
            setValue(
                newValue,
                forKey: key,
                options: []
            )
            
        }
        
    }
    
}

// MARK: - AnyMutableStorage

public class AnyMutableStorage<Key, Value>: MutableStorage where Key: Hashable {
    
    public typealias Collection = AnyStorage<Key, Value>
    
    public typealias Element = Collection.Element
    
    public typealias Index = Collection.Index
    
    public typealias Change = StorageChange<Key, Value>
    
    public typealias Changes = AnyCollection<Change>
    
    private let _storage: Collection
   
    private let _isLoaded: () -> Bool
    
    private let _load: () -> Void
    
    private let _setValue: (
        _ value: Value?,
        _ key: Key,
        _ options: ObservableValueOptions
    )
    -> Void
    
    private let _merge: (
        _ other: AnySequence< (key: Key, value: Value?) >,
        _ options: ObservableValueOptions
    )
    -> Void
    
    public init<S>(_ storage: S)
    where
        S: MutableStorage,
        S.Key == Key,
        S.Value == Value,
        S.Changes == Changes {
            
        self._storage = AnyStorage(storage)
            
        self._setValue = storage.setValue
    
        self._isLoaded = { storage.isLoaded }
            
        self._load = storage.load
            
        self._merge = storage.merge
            
    }
    
    public var startIndex: Index { return _storage.startIndex }
    
    public var endIndex: Index { return _storage.endIndex }
    
    public func index(after i: Index) -> Index { return _storage.index(after: i) }
    
    public var changes: Observable<Changes> { return _storage.changes }

    public var isLoaded: Bool { return _isLoaded() }
    
    public func load() { _load() }
    
    public subscript(position: Index) -> Element { return _storage[position] }
    
    public func value(
        forKey key: Key,
        completion: @escaping (Result<Value>) -> Void
    ) {
        
        _storage.value(
            forKey: key,
            completion: completion
        )
        
    }
    
    public func setValue(
        _ value: Value?,
        forKey key: Key,
        options: ObservableValueOptions = []
    ) {
        
        _setValue(
            value,
            key,
            options
        )
        
    }
    
    public func merge(
        _ other: AnySequence< (key: Key, value: Value?) >,
        options: ObservableValueOptions = []
    ) {
        
        _merge(
            other,
            options
        )
        
    }
    
}
