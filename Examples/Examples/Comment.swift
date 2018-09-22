//
//  Comment.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Comment

import TinyCore

public struct Comment: Unique, Codable, Equatable {
    
    public var identifier: String { return "\(id)" }
    
    public let id: Int
    
    public let username: String
    
    public let text: String
    
    public init(
        id: Int,
        username: String,
        text: String
    ) {
        
        self.id = id
        
        self.username = username
        
        self.text = text
        
    }
    
}

