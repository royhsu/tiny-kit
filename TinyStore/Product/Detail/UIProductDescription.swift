//
//  UIProductDescription.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDescription

public struct UIProductDescription {
    
    public var title: String?
    
    public var subtitle: String?
    
    public init(
        title: String? = nil,
        subtitle: String? = nil
    ) {
        
        self.title = title
        
        self.subtitle = subtitle
        
    }
    
}

