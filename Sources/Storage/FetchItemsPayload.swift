//
//  FetchItemsPayload.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - FetchItemsPayload

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

