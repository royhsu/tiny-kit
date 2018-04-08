//
//  UIProductGalleryView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension UIProductGalleryView {
    
    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UIProductGalleryView {
        
        backgroundColor = theme.backgroundColor
        
        triangleView.triangleColor = theme.backgroundColor
        
        imageView.backgroundColor = theme.placeholderColor
        
        return self
        
    }
    
}
