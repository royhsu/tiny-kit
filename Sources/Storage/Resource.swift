//
//  Resource.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Resource

import TinyCore

public protocol Resource {
    
    associatedtype Item
    
    typealias FetchItemsResult = Result< FetchItemsPayload<Item> >
    
    func fetchItems(
        page: Page,
        completionHandler: @escaping (FetchItemsResult) -> Void
    )
    
}

// MARK: - AnyResource

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
        completionHandler: @escaping (Result< FetchItemsPayload<Item> >) -> Void
    ) {
        
        _fetchItemsHandler(
            page,
            completionHandler
        )
        
    }
    
}

