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

internal struct MessageResource: Resource {
    
    internal typealias Message = String
    
    internal var fetchItemsResult: Result<FetchItemsPayload<Message>>
    
    internal func fetchItems(
        page: Page,
        completionHandler: @escaping (Result< FetchItemsPayload<Message> >) -> Void
    ) {
        
        completionHandler(fetchItemsResult)
        
    }
    
}
