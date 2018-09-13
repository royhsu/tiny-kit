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
    
    subscript(_ key: Key) -> Value? { get }
    
}

public extension Storage {

    public func value(forKey key: Key) -> Value? { return self[key] }
    
}

// MARK: - AnyStorage

public final class AnyStorage<Key, Value>: Storage where Key: Hashable & Comparable {

    private final let _valueProvider: (Key) -> Value?
    
    private final var subscriptions: [ObservableSubscription] = []

    public init<S: Storage>(_ storage: S) where S.Key == Key, S.Value == Value {

        self.keyDiff = storage.keyDiff

        self.maxKey = storage.maxKey
        
        self._valueProvider = storage.value
        
        self.prepare()

    }
    
    fileprivate final func prepare() {
        
        let subscription = keyDiff.subscribe { event in
            
            self.maxKey = event.currentValue?.max()
            
        }
        
        subscriptions.append(subscription)
        
    }
    
    // MARK: Storage
    
    public final let keyDiff: Observable<[Key]>
    
    public final private(set) var maxKey: Key?
    
    public final subscript(_ key: Key) -> Value? { return _valueProvider(key) }

}
