//
//  CommentTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CommentTemplate

import TinyKit

//public struct CommentTemplate: Template {
//    
//    public enum Element {
//        
//        case username
//        
//        case text
//        
//    }
//    
//    public let storage: Comment
//    
//    public let elements: [Element]
//    
//    public init(
//        storage: Comment,
//        elements: [Element] = []
//    ) {
//        
//        self.storage = storage
//        
//        self.elements = elements
//        
//    }
//    
//    public var numberOfElements: Int { return elements.count }
//    
//    public func view(at index: Int) -> View {
//        
//        let element = elements[index]
//        
//        switch element {
//            
//        case .username:
//            
//            let label = TitleLabel()
//            
//            label.text = storage.username
//            
//            return label
//            
//        case .text:
//            
//            let label = BodyLabel()
//            
//            label.text = storage.text
//            
//            return label
//            
//        }
//        
//    }
//    
//}
