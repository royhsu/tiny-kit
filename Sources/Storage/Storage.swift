//
//  Storage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Storage

import TinyCore

// TODO: should drop the indexDiff and conform to Observable instead.
public protocol Storage {
    
    associatedtype Key: Hashable, Comparable
    
    associatedtype Value
    
    // TODO: should provide a way to get the diff pairs.
    var keyDiff: Observable< Set<Key> > { get }
    
    var pairs: AnyCollection< (key: Key, value: Value) > { get }
    
    func setPairs(
        _ pairs: AnyCollection< (key: Key, value: Value?) >,
        options: ObservableValueOptions?
    )
    
    func removeAll(options: ObservableValueOptions?)
    
}

public struct StorageChange<Key, Value>: Hashable where Key: Hashable {

    public typealias Element = (key: Key, value: Value?)
    
    public let key: Key

    public let value: Value?

    public init(key: Key, value: Value?) {

        self.key = key

        self.value = value

    }
    
    public static func == (
        lhs: StorageChange<Key, Value>,
        rhs: StorageChange<Key, Value>
    )
    -> Bool { return lhs.key == rhs.key }

    public func hash(into hasher: inout Hasher) {

        hasher.combine(key.hashValue)

    }

}

public enum StorageError<Key>: Error {
    
    case valueNotFound(key: Key)
    
}

public protocol NewStorage: Collection where Element == (key: Key, value: Value) {

    associatedtype Key: Hashable
    
    associatedtype Value
    
    subscript(key: Key) -> Value? { get }
    
    func value(
        forKey key: Key,
        completion: (Result<Value>) -> Void
    )
    
}

public protocol MutableStorage: NewStorage {
    
    associatedtype Changes: Collection
    where Changes.Element == StorageChange<Key, Value>
    
    var changes: Observable< Changes > { get }
    
    subscript(key: Key) -> Value? { get set }
    
    mutating func merge<S>(_ other: S)
    where
        S: Sequence,
        S.Element == (key: Key, value: Value?)
    
}

public extension NewStorage {
    
    public subscript(key: Key) -> Value? {
        
        guard
            let element = first(
                where: { $0.key == key }
            )
        else { return nil }
        
        return element.value
        
    }
    
}

public extension Storage where Key == Int {
    
    // TODO: should define a better name. setIndexedValues
    public func setValues(
        _ values: [Value?],
        options: ObservableValueOptions? = nil
    ) {
        
        let pairs = values.enumerated().map { ($0.offset, $0.element) }
        
        setPairs(
            AnyCollection(pairs),
            options: options
        )
        
    }
    
    /// The count of stored pairs.
    public var count: Int { return pairs.count }
    
    public var isEmpty: Bool { return pairs.isEmpty }
    
    public subscript(key: Key) -> Value? {
        
        get { return pairs.first { $0.key == key }?.value }
        
        set {
            
            setPairs(
                AnyCollection(
                    [
                        (key, newValue)
                    ]
                ),
                options: nil
            )
            
        }
        
    }
    
}

// MARK: - AnyStorage

public struct AnyStorage<Key, Value>: Storage
where Key: Hashable & Comparable {
    
    private let _keyDiff: () -> Observable< Set<Key> >
    
    private let _pairs: () -> AnyCollection< (key: Key, value: Value) >
    
    private let _setPairs: (
        _ pairs: AnyCollection< (key: Key, value: Value?) >,
        _ options: ObservableValueOptions?
    )
    -> Void
    
    private let _removeAll: (ObservableValueOptions?) -> Void

    public init<S: Storage>(_ storage: S)
    where
        S.Key == Key,
        S.Value == Value {

        self._keyDiff = { storage.keyDiff }
            
        self._pairs = { storage.pairs }
            
        self._setPairs = storage.setPairs
            
        self._removeAll = storage.removeAll
            
    }
    
    public var keyDiff: Observable< Set<Key> > { return _keyDiff() }
    
    public var pairs: AnyCollection< (key:Key, value: Value) > { return _pairs() }
    
    public func setPairs(
        _ pairs: AnyCollection< (key: Key, value: Value?) >,
        options: ObservableValueOptions? = nil
    ) {
        
        _setPairs(
            pairs,
            options
        )
        
    }
    
    public func removeAll(options: ObservableValueOptions? = nil) { _removeAll(options) }
    
}
