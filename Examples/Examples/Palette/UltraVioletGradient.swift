//
//  UltraVioletGradient.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/29.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UltraVioletGradient

import TinyKit

public struct UltraVioletGradient {
    
    private let controller = CollectionViewController()
    
    public init() {
        
        let layout = CarouselViewLayout()
        
        layout.setWidthForItem { _, _, _ in 100.0 }
        
        layout.showsScrollIndicator = false
        
        layout.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        layout.collectionView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        controller.layout = layout
        
        controller.sections = [
            UltraVioletTemplate()
        ]
        
    }
    
    public var view: View { return controller.view }
    
}
