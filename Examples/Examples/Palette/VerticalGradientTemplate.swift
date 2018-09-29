//
//  VerticalGradientTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - VerticalGradientTemplate

import TinyKit

public struct VerticalGradientTemplate: Template {
    
    private let template: GradientTemplate
    
    public init(
        startColor: DynamicColor,
        endColor: DynamicColor,
        amount: UInt
    ) {
        
        self.template = GradientTemplate(
            startColor: startColor,
            endColor: endColor,
            amount: amount
        )
        
    }
    
    public var numberOfViews: Int { return template.numberOfViews }
    
    public func view(at index: Int) -> View {
        
        let view = template.view(at: index)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.removeConstraints(view.constraints)
        
        view.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        return view
        
    }
    
}

