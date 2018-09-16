//
//  Comment.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Comment

public struct Comment: Codable, Equatable {
    
    public let username: String
    
    public let text: String
    
    public init(
        username: String,
        text: String
    ) {
        
        self.username = username
        
        self.text = text
        
    }
    
}

