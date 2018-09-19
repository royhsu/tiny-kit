//
//  ConfigurableStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/19.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ConfigurableStorage

import TinyCore

public final class ConfigurableStorage<Key, Value>: Storage, Initializable where Key: Hashable {
    
    public typealias Cache = MemoryCache<Key, Value>
    
    private typealias SecondaryStorage = AnyStorage<Key, Value>
    
    public typealias Element = Cache.Element
    
    public typealias Index = Cache.Index
    
    private final var cache = Cache()
    
    private final var secondaryStorages: [SecondaryStorage] = []
    
    public required init() { }
    
    public final var startIndex: Index { return cache.startIndex }
    
    public final var endIndex: Index { return cache.endIndex }
    
    public final func index(after i: Index) -> Index { return cache.index(after: i) }
    
    public final subscript(position: Index) -> Element { return cache[position] }
    
    /// The storage will use the firstly returned value by secondary storages.
    /// The order of looking up a value is the same as the order of the secondary storage being added.
    /// The earlier has higher priority.
    public final func value(
        forKey key: Key,
        completion: @escaping (Result<Value>) -> Void
    ) {
        
        var value: Value?
        
        let group = DispatchGroup()
        
        for storage in secondaryStorages {
            
            group.enter()
            
            storage.value(forKey: key) { result in
                
                defer { group.leave() }
                
                let hasValue = (value != nil)
                
                if hasValue { return }
                
                guard
                    let firstValue = try? result.resolve()
                    else { return }
                
                value = firstValue
                
            }
            
            let hasValue = (value != nil)
            
            if hasValue { break }
            
        }
        
        group.notify(
            queue: .global(qos: .background)
        ) {
            
            if let value = value {
                
                completion(
                    .success(value)
                )
                
                return
                
            }
            
            let error: StorageError<Key> = .valueNotFound(key: key)
            
            completion(
                .failure(error)
            )
            
        }
        
    }
    
    public final func registerSecondaryStorage<S>(_ storage: S)
    where
    S: Storage,
    S.Key == Key,
    S.Value == Value {
        
        secondaryStorages.append(
            AnyStorage(storage)
        )
            
    }
    
    public final func registerSecondaryStorage<S>(_ storageType: S.Type)
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

