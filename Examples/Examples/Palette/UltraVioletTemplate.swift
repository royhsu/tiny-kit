//
//  UltraVioletTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UltraVioletTemplate

import TinyKit

public struct UltraVioletTemplate: Template {
    
    private let startColor = DynamicColor(hexString: "654ea3")
    
    private let endColor = DynamicColor(hexString: "#eaafc8")
    
    private let colors: [DynamicColor]
    
    public init() {
        
        let gradient = DynamicGradient(
            colors: [
                startColor,
                endColor
            ]
        )
        
        self.colors = gradient.colorPalette(amount: 10)
        
    }
    
    public var numberOfViews: Int { return colors.count }
    
    public func view(at index: Int) -> View {
        
        let color = colors[index]
        
        let view = View()
        
        view.backgroundColor = color
        
        return view
        
    }
    
}
