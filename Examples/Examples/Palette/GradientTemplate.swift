//
//  GradientTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - GradientTemplate

import TinyKit

public struct GradientTemplate: Template {
    
    private let colors: [DynamicColor]
    
    public init(
        startColor: DynamicColor,
        endColor: DynamicColor,
        amount: UInt
    ) {
        
        let gradient = DynamicGradient(
            colors: [
                startColor,
                endColor
            ]
        )
        
        self.colors = gradient.colorPalette(amount: amount)
        
    }
    
    public var numberOfViews: Int { return colors.count }
    
    public func view(at index: Int) -> View {
        
        let color = colors[index]
        
        let view = View()
        
        view.backgroundColor = color
        
        return view
        
    }
    
}
