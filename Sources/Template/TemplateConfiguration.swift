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
    
    func preferredViewType(for element: Element) -> View.Type?
    
}

// MARK: - Default Implementation

public extension TemplateConfiguration {
    
    public func preferredViewType(for element: Element) -> View.Type? { return nil }
    
}
