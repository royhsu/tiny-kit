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
    
    public typealias Key = Int
    
    public enum Value {

        case post(Post)

        case comment(Comment)

    }

    public typealias Cache = MemoryCache<Int, Value>
    
    public typealias Change = StorageChange<Int, Value>
    
    public typealias Changes = Set<Change>
    
    public typealias Index = Cache.Index
    
    public typealias Element = Cache.Element
    
    public var startIndex: Index { return cache.startIndex }
    
    public var endIndex: Index { return cache.endIndex }
    
    public var changes: Observable<Changes> { return cache.changes }
    
    public var isLoaded: Bool { return cache.isLoaded }
    
    private let cache: Cache
    
    public init() { self.cache = Cache() }
    
    public func load(completion: LoadCompletion?) {
       
        cache.load { _ in
            
            let remote = RemoteStorage(
                resource: PostResource(client: URLSession.shared)
            )
            
            remote.load { result in
                
                let values: [ (Int, Value?) ] = remote.lazy.map {
                    
                    return (
                        $0.key,
                        .post($0.value)
                    )
                    
                }
                
                self.cache.removeAll(options: .muteBroadcaster)
                
                self.cache.merge(
                    AnySequence(values)
                )
                
                remote.removeAll()
                
                completion?(result)
                
            }
            
        }
        
    }
    
    public func index(after i: Index) -> Index { return cache.index(after: i) }
    
    public subscript(position: Index) -> Element { return cache[position] }
    
    public func value(
        forKey key: Int,
        completion: @escaping (Result<Value>) -> Void
    ) {
        
        cache.value(
            forKey: key,
            completion: completion
        )
        
    }
    
    public func setValue(
        _ value: Value?,
        forKey key: Int,
        options: ObservableValueOptions = []
    ) {
        
        cache.setValue(
            value,
            forKey: key,
            options: options
        )
        
    }
    
    public func merge(
        _ other: AnySequence< (key: Int, value: Value?) >,
        options: ObservableValueOptions = []
    ) {
        
        cache.merge(
            other,
            options: options
        )
        
    }
    
    public func removeAll(options: ObservableValueOptions) { cache.removeAll(options: options) }
    
}
