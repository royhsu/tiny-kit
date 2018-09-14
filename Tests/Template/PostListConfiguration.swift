//
//  PostListConfiguration.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostListConfiguration

import TinyKit

internal struct PostListConfiguration: TemplateConfiguration {
    
    internal typealias Element = PostListElement
    
    internal typealias PreferredViewNameProvider = (PostListElement) -> String?
    
    internal let preferredViewNameProvider: PreferredViewNameProvider?
    
    internal func preferredViewName(for element: Element) -> String? { return preferredViewNameProvider?(element) }
    
}
