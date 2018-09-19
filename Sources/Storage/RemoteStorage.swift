//
//  RemoteStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - RemoteStorage

import TinyCore

public final class RemoteStorage<Item>: MutableStorage where Item: Decodable {
    
    public typealias Change = StorageChange<Int, Item>
    
    public typealias Changes = Set<Change>
    
    public typealias Cache = MemoryCache<Int, Item>
    
    public typealias Element = Cache.Element
    
    public typealias Index = Cache.Index
    
    private final let resource: AnyResource<Item>

    public final var changes: Observable<Changes> { return cache.changes }
    
    private final var cache = Cache()

    private final var _isLoaded = false
    
    public final var isLoaded: Bool { return _isLoaded }
    
    public init<R: Resource>(resource: R) where R.Item == Item { self.resource = AnyResource(resource) }

    public final var startIndex: Index { return cache.startIndex }
    
    public final var endIndex: Index { return cache.endIndex }
    
    public final func index(after i: Index) -> Index { return cache.index(after: i) }
    
    public final subscript(position: Index) -> Element { return cache[position] }
    
    /// The storage will try to fetch items from the given resource if there is no value related to the key.
    public final func value(
        forKey key: Int,
        completion: @escaping (Result<Item>) -> Void
    ) {
        
        if let value = cache[key] {
            
            completion(
                .success(value)
            )
         
            return
            
        }
        
    }
    
    public final func removeAll() { cache = [:] }
    
    public final subscript(key: Int) -> Item? {
        
        get { return cache[key] }
        
        set { cache[key] = newValue }
        
    }
    
    public final func load() {
        
        resource.fetchItems(page: .first) { [weak self] result in
            
            defer { self?._isLoaded = true }
            
            guard
                let self = self,
                let payload = try? result.resolve()
            else { return }
            
            self.cache.merge(
                payload.items.enumerated().map { $0 }
            )
            
//            if let value = self[key] {
//
//                completion(
//                    .success(value)
//                )
//
//                return
//
//            }
//
//            let error: StorageError<Int> = .valueNotFound(key: key)
//
//            completion(
//                .failure(error)
//            )
            
        }
        
    }
    
    public final func merge<S>(
        _ other: S,
        options: ObservableValueOptions = []
    )
    where
        S : Sequence,
        S.Element == (key: Int, value: Item?) {
     
        cache.merge(
            other,
            options: options
        )
            
    }

}