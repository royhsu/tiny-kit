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
    
    var keyDiff: Observable<[Key]> { get }
    
    var values: AnyCollection<Value> { get }
    
    func setPairs(_ pairs: AnyCollection<(Key, Value)>)
    
}

public extension Storage where Key == Int {
    
    // TODO: add unit test.
    public func setValues(
        _ values: [Value]
    ) {
        
        let pairs = values.enumerated().map { ($0.offset, $0.element) }
        
        setPairs(
            AnyCollection(pairs)
        )
        
    }
    
}

// MARK: - AnyStorage

public struct AnyStorage<Key, Value>: Storage
where Key: Hashable & Comparable {
    
    private let _keyDiff: () -> Observable<[Key]>
    
    private let _values: () -> AnyCollection<Value>
    
    private let _setPairs: (AnyCollection<(Key, Value)>) -> Void

    public init<S: Storage>(_ storage: S)
    where
        S.Key == Key,
        S.Value == Value {

        self._keyDiff = { storage.keyDiff }
            
        self._values = { storage.values }
            
        self._setPairs = storage.setPairs
            
    }
    
    // MARK: Storage
    
    public var keyDiff: Observable<[Key]> { return _keyDiff() }
    
    public var values: AnyCollection<Value> { return _values() }
    
    public func setPairs(
        _ pairs: AnyCollection<(Key, Value)>
    ) { _setPairs(pairs) }
    
}
