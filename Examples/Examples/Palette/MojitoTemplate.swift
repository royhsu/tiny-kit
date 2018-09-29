//
//  MojitoTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MojitoTemplate

import TinyKit

public struct MojitoTemplate: Template {
    
    private let startColor = DynamicColor(hexString: "1d976c")
    
    private let endColor = DynamicColor(hexString: "#93f9b9")
    
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
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        return view
        
    }
    
}
