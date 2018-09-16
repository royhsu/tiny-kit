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
    
    typealias KeyDiff = Observable<[Key]>
    
    var keyDiff: KeyDiff { get }
    
    var maxKey: Key? { get }
    
    func value(forKey key: Key) -> Value?
    
}

public extension Storage {

    public subscript(key: Key) -> Value? { return value(forKey: key) }
    
}

// MARK: - AnyStorage

public final class AnyStorage<Key, Value>: Storage
where Key: Hashable & Comparable {
    
    private final let _keyDiff: () -> KeyDiff
    
    private final let _maxKey: () -> Key?
    
    private final let _value: (Key) -> Value?

    public init<S: Storage>(_ storage: S)
    where
        S.Key == Key,
        S.Value == Value {

        self._keyDiff = { storage.keyDiff }

        self._maxKey = { storage.maxKey }
        
        self._value = storage.value
            
    }
    
    // MARK: Storage
    
    public final var keyDiff: Observable<[Key]> { return _keyDiff() }
    
    public final var maxKey: Key? { return _maxKey() }
    
    public final func value(forKey key: Key) -> Value? { return _value(key) }

}
