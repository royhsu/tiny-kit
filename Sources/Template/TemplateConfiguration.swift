//
//  TemplateConfiguration.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TemplateConfiguration

public protocol TemplateConfiguration {
    
    associatedtype Element: Hashable
    
    func preferredViewName(for element: Element) -> String?
    
}

// MARK: - Default Implementation

public extension TemplateConfiguration {
    
    public func preferredViewName(for element: Element) -> String? { return nil }
    
}
