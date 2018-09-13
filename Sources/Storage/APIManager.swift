//
//  APIManager.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - APIManager

import TinyCore

public final class APIManager<Item>: Storage where Item: Decodable {
    
    private final let resource: AnyResource<Item>
    
    /// The base storage.
    private final let _memoryCache = MemoryCache<Int, Item>()
    
    public init<R: Resource>(resource: R) where R.Item == Item { self.resource = AnyResource(resource) }
    
    public final func load() {
        
        resource.fetchItems(page: .first) { [weak self] result in
            
            guard
                let self = self,
                let payload = try? result.resolve()
            else { return }
            
            self._memoryCache.setValues(payload.items)
            
        }
        
    }
    
    // MARK: Storage
    
    public final var keyDiff: KeyDiff { return _memoryCache.keyDiff }
    
    public final var maxKey: Int? { return _memoryCache.maxKey }
    
    public final subscript(key: Int) -> Item? { return _memoryCache[key] }

}
