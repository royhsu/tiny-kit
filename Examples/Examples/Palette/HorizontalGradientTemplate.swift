//
//  HorizontalGradientTemplate.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - HorizontalGradientTemplate

import TinyKit

public struct HorizontalGradientTemplate: Template {
    
    private let controller = CollectionViewController()
    
    public init(
        startColor: DynamicColor,
        endColor: DynamicColor,
        amount: UInt
    ) {
        
        let layout = CarouselViewLayout()
        
        layout.setWidthForItem { _, _, _ in 100.0 }
        
        layout.showsScrollIndicator = false
        
        layout.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        layout.collectionView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        controller.layout = layout
        
        controller.sections = [
            GradientTemplate(
                startColor: startColor,
                endColor: endColor,
                amount: amount
            )
        ]
        
    }
    
    public var numberOfViews: Int { return 1 }
    
    public func view(at index: Int) -> View { return controller.view }
    
}
