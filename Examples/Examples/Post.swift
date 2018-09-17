//
//  Post.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Post

public struct Post: Codable, Equatable {
    
    public let id: Int
    
    public let title: String
    
    public let body: String
    
    public let isLiked: Bool = false
    
    public init(
        id: Int,
        title: String,
        body: String
    ) {

        self.id = id
        
        self.title = title
        
        self.body = body
        
    }
        
}
