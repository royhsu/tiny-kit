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
    
    var pairs: AnyCollection<(key: Key, value: Value)> { get }
    
    func setPairs(_ pairs: AnyCollection<(key:Key, value:Value)>)
    
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
    
    private let _pairs: () -> AnyCollection<(key: Key, value: Value)>
    
    private let _setPairs: (AnyCollection<(key: Key, value: Value)>) -> Void

    public init<S: Storage>(_ storage: S)
    where
        S.Key == Key,
        S.Value == Value {

        self._keyDiff = { storage.keyDiff }
            
        self._pairs = { storage.pairs }
            
        self._setPairs = storage.setPairs
            
    }
    
    // MARK: Storage
    
    public var keyDiff: Observable<[Key]> { return _keyDiff() }
    
    public var pairs: AnyCollection<(key:Key, value: Value)> { return _pairs() }
    
    public func setPairs(
        _ pairs: AnyCollection<(key: Key, value: Value)>
    ) { _setPairs(pairs) }
    
}
