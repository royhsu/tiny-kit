//
//  UICartItemView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 19/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension UICartItemView {
    
    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UICartItemView {
        
        backgroundColor = theme.backgroundColor
        
        previewImageView.backgroundColor = theme.placeholderColor
        
        titleLabel.textColor = theme.subtitleColor
        
        priceLabel.textColor = theme.titleColor
        
        return self
        
    }
    
}