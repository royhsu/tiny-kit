//
//  APIStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - APIStorage

import TinyCore

public final class APIStorage<Item>: Storage {
    
    public final var maxKey: Int?
    
    public final subscript(key: Int) -> Item? {
        
        return nil
        
    }
    
    private final let resource: AnyResource<Item>
    
    public final let keyDiff = KeyDiff()
    
    public init<R: Resource>(resource: R) where R.Item == Item { self.resource = AnyResource(resource) }
    
    public final func load() {
        
        
    }

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
        items: [Item],
        next: Page?
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
