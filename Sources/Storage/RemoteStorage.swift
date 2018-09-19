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
    
    public typealias Change = StorageChange<Int, Value>
    
    public typealias Changes = Set<Change>
    
    public typealias Cache = MemoryCache<Int, Item>
    
    public typealias Element = Cache.Element
    
    public typealias Index = Cache.Index
    
    private final let resource: AnyResource<Item>

    public final var changes: Observable<Changes> { return cache.changes }
    
    private final var cache = Cache()

    public init<R: Resource>(resource: R) where R.Item == Item { self.resource = AnyResource(resource) }

    public final var startIndex: Index { return cache.startIndex }
    
    public final var endIndex: Index { return cache.endIndex }
    
    public final func index(after i: Index) -> Index { return cache.index(after: i) }
    
    public final subscript(position: Index) -> Element { return cache[position] }
    
    public final func value(
        forKey key: Int,
        completion: @escaping (Result<Item>) -> Void
    ) {
        
        cache.value(
            forKey: key,
            completion: completion
        )
        
    }
    
    public final func removeAll() { cache = [:] }

    public final func load() {

        resource.fetchItems(page: .first) { [weak self] result in

            guard
                let self = self,
                let payload = try? result.resolve()
            else { return }

            self.cache.merge(
                payload.items.enumerated().map { $0 }
            )

        }

    }
    
    public final subscript(key: Int) -> Item? {
        
        get { return cache[key] }
        
        set { cache[key] = newValue }
        
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
