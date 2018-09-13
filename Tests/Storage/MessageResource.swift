//
//  MessageResource.swift
//  TinyKit iOS
//
//  Created by Roy Hsu on 2018/9/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MessageResource

import TinyCore
import TinyKit

internal final class MessageResource: Resource {
    
    internal typealias Message = String
    
    internal final func fetchItems(
        page: Page,
        completionHandler: @escaping (Result< FetchItemsPayload<Message> >) -> Void
    ) {
        
        completionHandler(
            .success(
                FetchItemsPayload(
                    items: [
                        "Hello",
                        "World"
                    ],
                    next: nil
                )
            )
        )
        
    }
    
}
