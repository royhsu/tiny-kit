//
//  APIStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - APIStorage

import TinyCore

public final class APIStorage<Item>: Storage where Item: Decodable {
    
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

public enum Page {
    
    case first
    
    case next
    
    case last
    
}

public struct FetchItemsPayload<Item> {
    
    public let items: [Item]
    
    public let next: Page?
    
    public init(
        items: [Item] = [],
        next: Page? = nil
    ) {
        
        self.items = items
        
        self.next = next
        
    }
    
}

// TODO: Resource -> Service?
public protocol Resource {
    
    associatedtype Item
    
    typealias FetchItemsResult = Result<FetchItemsPayload<Item>>
    
    func fetchItems(
        page: Page,
        completionHandler: @escaping (FetchItemsResult) -> Void
    )
    
}

public struct AnyResource<Item>: Resource {
    
    private let _fetchItemsHandler: (
        _ page: Page,
        _ completionHandler: @escaping (FetchItemsResult) -> Void
    )
    -> Void
    
    public init<R: Resource>(_ resource: R) where R.Item == Item {
        
        self._fetchItemsHandler = resource.fetchItems
        
    }
    
    public func fetchItems(
        page: Page,
        completionHandler: @escaping (Result<FetchItemsPayload<Item>>) -> Void) {
        
        _fetchItemsHandler(
            page,
            completionHandler
        )
        
    }
    
}
