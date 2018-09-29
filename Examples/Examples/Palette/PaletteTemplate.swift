//
//  PaletteTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PaletteTemplate

import TinyKit

public enum PaletteTemplate: Template {
    
    case horizontal(HorizontalGradientTemplate)
    
    case vertical(VerticalGradientTemplate)
    
    public var numberOfViews: Int {
        
        switch self {
            
        case let .horizontal(gradient): return gradient.numberOfViews
            
        case let .vertical(gradient): return gradient.numberOfViews
            
        }
        
    }
    
    public func view(at index: Int) -> View {
        
        switch self {
            
        case let .horizontal(gradient): return gradient.view(at: index)
            
        case let .vertical(gradient): return gradient.view(at: index)
            
        }
        
    }
    
}
