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
    
    subscript(key: Key) -> Value? { get }
    
    func value(
        forKey key: Key,
        completion: @escaping (Result<Value>) -> Void
    )
    
}

// MARK: - Default Implementation

public extension Storage {
    
    public subscript(key: Key) -> Value? {
        
        guard
            let element = first(
                where: { $0.key == key }
            )
        else { return nil }
        
        return element.value
        
    }
    
}

public extension Storage {
    
    public func value(forKey key: Key) -> Value? { return self[key] }
    
}

// MARK: - AnyStorage

public struct AnyStorage<Key, Value>: Storage where Key: Hashable {
    
    public typealias Element = (key: Key, value: Value)
    
    public typealias Collection = AnyCollection<Element>
    
    public typealias Index = Collection.Index
    
    private let _collection: Collection
    
    private let _value: (Key) -> Value?
    
    private let _valueWithCompletion: (
        _ key: Key,
        _ completion: @escaping (Result<Value>) -> Void
    )
    -> Void
    
    public init<S: Storage>(_ storage: S)
    where S.Key == Key, S.Value == Value {
        
        self._collection = AnyCollection(storage)
        
        self._value = storage.value
        
        self._valueWithCompletion = storage.value
        
    }
    
    public var startIndex: Index { return _collection.startIndex }
    
    public var endIndex: Index { return _collection.endIndex }
    
    public func index(after i: Index) -> Index { return _collection.index(after: i) }
    
    public subscript(key: Key) -> Value? { return _value(key) }
    
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

public protocol Initializable {
    
    init()
    
}

public struct ConfigurableStorage<Key, Value>: Storage where Key: Hashable {
    
    public typealias Cache = MemoryCache<Key, Value>

    private typealias SecondaryStorage = AnyStorage<Key, Value>
    
    public typealias Element = Cache.Element
    
    public typealias Index = Cache.Index
    
    private var primaryStorage = Cache()
    
    private var secondaryStorages: [SecondaryStorage] = []
    
    public var startIndex: Index { return primaryStorage.startIndex }
    
    public var endIndex: Index { return primaryStorage.endIndex }
    
    public func index(after i: Index) -> Index { return primaryStorage.index(after: i) }
    
    public subscript(position: Index) -> Element { return primaryStorage[position] }
    
    public func value(
        forKey key: Key,
        completion: @escaping (Result<Value>) -> Void
    ) {
        
        primaryStorage.value(
            forKey: key,
            completion: completion
        )
        
    }
    
    public mutating func registerStorage<S>(_ storage: S)
    where S: Storage, S.Key == Key, S.Value == Value {
        
        secondaryStorages.append(
            AnyStorage(storage)
        )
        
    }
    
    public mutating func registerStorage<S>(_ storageType: S.Type)
    where
        S: Storage & Initializable,
        S.Key == Key,
        S.Value == Value {
        
        let storage = S.init()
        
        secondaryStorages.append(
            AnyStorage(storage)
        )
        
    }
    
}

//public extension Storage where Key == Int {
//    
//    // TODO: should define a better name. setIndexedValues
//    public func setValues(
//        _ values: [Value?],
//        options: ObservableValueOptions? = nil
//    ) {
//        
//        let pairs = values.enumerated().map { ($0.offset, $0.element) }
//        
//        setPairs(
//            AnyCollection(pairs),
//            options: options
//        )
//        
//    }
//    
//    /// The count of stored pairs.
//    public var count: Int { return pairs.count }
//    
//    public var isEmpty: Bool { return pairs.isEmpty }
//    
//    public subscript(key: Key) -> Value? {
//        
//        get { return pairs.first { $0.key == key }?.value }
//        
//        set {
//            
//            setPairs(
//                AnyCollection(
//                    [
//                        (key, newValue)
//                    ]
//                ),
//                options: nil
//            )
//            
//        }
//        
//    }
//    
//}
