//
//  Storage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Storage

import TinyCore

public protocol Storage: Collection where Element == (key: Key, value: Value) {

    associatedtype Key: Hashable
    
    associatedtype Value
    
    associatedtype Changes: Collection where Changes.Element == StorageChange<Key, Value>
    
    var changes: Observable<Changes> { get }
    
    func value(forKey key: Key) -> Value?
    
    /// The storage returns a value asynchronously.
    #warning("seems like no compelling use case to keep this function on the protocol.")
    func value(
        forKey key: Key,
        completion: @escaping (Result<Value>) -> Void
    )
    
}

// MARK: - Default Implementation

public extension Storage {
    
    public func value(forKey key: Key) -> Value? {
        
        guard
            let element = first(
                where: { $0.key == key }
            )
        else { return nil }
        
        return element.value
        
    }
    
}

public extension Storage {
    
    public subscript(key: Key) -> Value? { return value(forKey: key) }
    
}

// MARK: - AnyStorage

public struct AnyStorage<Key, Value>: Storage where Key: Hashable {
    
    public typealias Element = (key: Key, value: Value)
    
    public typealias Collection = AnyCollection<Element>
    
    public typealias Index = Collection.Index
    
    public typealias Change = StorageChange<Key, Value>
    
    public typealias Changes = AnyCollection<Change>
    
    private let _collection: Collection
    
    private let _changes: () -> Observable<Changes>
    
    private let _value: (Key) -> Value?
    
    private let _valueWithCompletion: (
        _ key: Key,
        _ completion: @escaping (Result<Value>) -> Void
    )
    -> Void
    
    public init<S>(_ storage: S)
    where
        S: Storage,
        S.Key == Key,
        S.Value == Value,
        S.Changes == Changes {
        
        self._collection = AnyCollection(storage)
        
        self._changes = { storage.changes }
        
        self._value = storage.value
        
        self._valueWithCompletion = storage.value
        
    }
    
    public var startIndex: Index { return _collection.startIndex }
    
    public var endIndex: Index { return _collection.endIndex }
    
    public func index(after i: Index) -> Index { return _collection.index(after: i) }
    
    public var changes: Observable<Changes> { return _changes() }
    
    public subscript(position: Index) -> Element { return _collection[position] }
    
    public func value(
        forKey key: Key,
        completion: @escaping (Result<Value>) -> Void
    ) {
        
        _valueWithCompletion(
            key,
            completion
        )
        
    }
    
}
