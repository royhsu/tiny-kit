//
//  PostStorage.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostStorage

import TinyCore
import TinyKit

public struct PostStorage: MutableStorage {
    
    public enum Value {
        
        case post(Post)
        
        case comment(Comment)
        
    }

    public typealias Storage = NewMemoryCache<Int, Value>
    
    public typealias Element = Storage.Element
    
    public typealias Change = StorageChange<Int, Value>
    
    public typealias Changes = Set<Change>
    
    public typealias Index = Storage.Index
    
//    private final var storage: AnyStorage<Int, Value> {
//
//        return AnyStorage(_memoryStorage)
//
//    }
    
    private var _memoryStorage = NewMemoryCache<Int, Value>()
    
//    private final var _apiManager: APIManager<Post>?
    
//    private final var subscriptions: [ObservableSubscription] = []
    
    public init(resource: PostResource? = nil) {
        
//        if let resource = resource {
//
//            let manager = APIManager(resource: resource)
//
//            let subscription = manager.keyDiff.subscribe { event in
//
//                let pairs: [ (key: Int, value: Value?) ] = manager.pairs.map { pair in
//
//                    return (
//                        pair.key,
//                        Value.post(pair.value)
//                    )
//
//                }
//
//                self._memoryStorage.setPairs(
//                    AnyCollection(pairs)
//                )
//
//            }
//
//            subscriptions.append(subscription)
//
//            _apiManager = manager
//
//        }
        
    }
    
    public func load() {
        
//        _apiManager?.load()
        
    }
    
    public var startIndex: Index { return _memoryStorage.startIndex }
    
    public var endIndex: Index { return _memoryStorage.endIndex }
    
    public func index(after i: Index) -> Index { return _memoryStorage.index(after: i) }
    
    public var changes: Observable<Changes> { return _memoryStorage.changes }
    
//    public final var pairs: AnyCollection< (key: Int, value: Value) > {
//
//        return AnyCollection(
//            storage.pairs.sorted { $0.key < $1.key }
//        )
//
//    }
//
//    public final func setPairs(_ pairs: AnyCollection< (key: Int, value: Value?) >) { storage.setPairs(pairs) }
    
    public subscript(key: Int) -> Value? {
        
        get { return _memoryStorage[key] }
        
        set { _memoryStorage[key] = newValue }
        
    }
    
    public subscript(position: Index) -> Element { return _memoryStorage[position] }
    
    public func value(
        forKey key: Int,
        completion: (Result<PostStorage.Value>) -> Void) {
        
        _memoryStorage.value(
            forKey: key,
            completion: completion
        )
        
    }
    
    public mutating func merge<S>(_ other: S)
    where S : Sequence, S.Element == (key: Int, value: Value?) { _memoryStorage.merge(other) }
    
}
