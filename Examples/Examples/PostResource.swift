//
//  PostResource.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostResource

import TinyCore
import TinyKit

public final class PostResource {
    
    private final let client: HTTPClient
    
    public init(client: HTTPClient) { self.client = client }
    
    public final func fetchPost(
        id: String,
        completionHandler: @escaping (Result<Post>) -> Void
    ) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!
        
        client.request(
            URLRequest(url: url),
            decoder: JSONDecoder(),
            completionHandler: completionHandler
        )
        
    }
    
    public final func fetchPosts(
        completionHandler: @escaping (Result<[Post]>) -> Void
    ) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        client.request(
            URLRequest(url: url),
            decoder: JSONDecoder(),
            completionHandler: completionHandler
        )
        
    }
    
}

extension PostResource: Resource {
    
    public final func fetchItems(
        page: Page,
        completionHandler: @escaping (Result<FetchItemsPayload<Post>>) -> Void
    ) {
        
        fetchPosts { result in
            
            switch result {
                
            case let .success(posts):
                
                completionHandler(
                    .success(
                        FetchItemsPayload(items: posts)
                    )
                )
                
            case let .failure(error):
                
                completionHandler(
                    .failure(error)
                )
                
            }
            
        }
        
    }
    
}
