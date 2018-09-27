//
//  PostTemplateConfiguration.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostTemplateConfiguration

import TinyKit

internal struct PostTemplateConfiguration: TemplateConfiguration {
    
    public enum Element: String {
        
        case title
        
        case body
        
    }
    
    internal let preferredViewType: (Element) -> View.Type?
    
    internal func preferredViewType(for element: Element) -> View.Type? { return preferredViewType(element) }
    
}
