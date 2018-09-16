//
//  PostTemplateConfiguration.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostTemplateConfiguration

import TinyKit

public struct PostTemplateConfiguration: TemplateConfiguration {
    
    public enum Element: String {
        
        case title
        
        case body
        
    }
    
    public func preferredViewName(for element: Element) -> String? {
        
        switch element {
            
        case .title: return "LargeTitleLabel"
            
        case .body: return nil
            
        }
        
    }
    
}
