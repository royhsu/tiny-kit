//
//  Post.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Post

import TinyCore

public struct Post: Unique, Codable, Equatable {
    
    public var identifier: String { return "\(id)" }
    
    public let id: Int
    
    public let title: String
    
    public let body: String
    
    public var isLiked: Bool = false
    
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

// MARK: - LikeButtonStorage

extension Post: LikeButtonStorage { }
