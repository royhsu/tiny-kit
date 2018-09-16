//
//  PostTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostTemplate

import TinyKit

public struct PostTemplate: Template {
    
    public enum Element {
        
        case title
        
        case body
        
    }
    
    public let storage: Post
    
    public let elements: [Element]
    
    public init(
        storage: Post,
        elements: [Element]
    ) {
        
        self.storage = storage
        
        self.elements = elements
        
    }
    
    public var numberOfElements: Int { return elements.count }
    
    public func view(at index: Int) -> View {
        
        let element = elements[index]
        
        switch element {
            
        case .title:
            
            let label = TitleLabel()
            
            label.text = storage.title
            
            return label
            
        case .body:
            
            let label = BodyLabel()
            
            label.text = storage.body
            
            return label
            
        }
        
    }
    
}
