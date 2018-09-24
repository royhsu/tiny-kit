//
//  FeedSectionCollection.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - FeedSectionCollection

import TinyKit

public struct FeedSectionCollection: SectionCollection {
    
    public enum Section: Template {
        
        public typealias Element = Any
        
        case post(PostTemplate)
        
//        case comment(CommentTemplate)
        
        case comment(AnswerTemplate)
        
        public var storage: Any {
            
            switch self {
                
            case let .post(template): return template.storage
            
            case let .comment(template): return template.storage
                
            }
            
        }
        
        public var numberOfElements: Int {
            
            switch self {
                
            case let .post(template): return template.numberOfElements
                
            case let .comment(template): return template.numberOfElements
                
            }
            
        }
        
        public func view(at index: Int) -> View {
            
            switch self {
                
            case let .post(template): return template.view(at: index)
                
            case let .comment(template): return template.view(at: index)
                
            }
            
        }
        
    }
    
    public var sections: [Section]
    
    public init(
        sections: [Section]
    ) { self.sections = sections }
    
    public var count: Int { return sections.count }
    
    public func section(at index: Int) -> Section { return sections[index] }
    
}
