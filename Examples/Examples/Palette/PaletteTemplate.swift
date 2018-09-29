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
    
    case ultraViolet(UltraVioletGradient)
    
    case mojito(MojitoGradient)
    
    public var numberOfViews: Int {
        
        switch self {
            
        case .ultraViolet: return 1
            
        case let .mojito(gradient): return gradient.template.numberOfViews
            
        }
        
    }
    
    public func view(at index: Int) -> View {
        
        switch self {
            
        case let .ultraViolet(gradient): return gradient.view
            
        case let .mojito(gradient): return gradient.template.view(at: index)
            
        }
        
    }
    
}
