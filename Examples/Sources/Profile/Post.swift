//
//  Post.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Post

public struct Post: Codable {
    
    public var title: String?
    
    public var content: String?
    
    public init(
        title: String?,
        content: String?
    ) {
        
        self.title = title
        
        self.content = content
        
    }
    
}
