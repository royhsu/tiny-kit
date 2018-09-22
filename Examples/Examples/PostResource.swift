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
import TinyStorage

public final class PostResource {
    
    private final let client: HTTPClient
    
    public init(client: HTTPClient) { self.client = client }
    
    public final func fetchPost(
        id: String,
        completion: @escaping (Result<Post>) -> Void
    ) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!
        
        client.request(
            URLRequest(url: url),
            decoder: JSONDecoder(),
            completion: completion
        )
        
    }
    
    public final func fetchPosts(
        completion: @escaping (Result<[Post]>) -> Void
    ) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        client.request(
            URLRequest(url: url),
            decoder: JSONDecoder(),
            completion: completion
        )
        
    }
    
}

// MARK: - Resource

extension PostResource: Resource {
    
    public final func fetchItems(
        page: Page,
        completion: @escaping (Result< FetchItemsPayload<Feed> >) -> Void
    ) {
        
        fetchPosts { result in
            
            switch result {
                
            case let .success(posts):
                
                completion(
                    .success(
                        FetchItemsPayload(
                            items: posts.map { $0.feed }
                        )
                    )
                )
                
            case let .failure(error):
                
                completion(
                    .failure(error)
                )
                
            }
            
        }
        
    }
    
}
