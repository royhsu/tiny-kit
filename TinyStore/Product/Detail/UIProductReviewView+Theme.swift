//
//  UIProductReviewView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension UIProductReviewView {

    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UIProductReviewView {
        
        backgroundColor = theme.backgroundColor
        
        pictureImageView.backgroundColor = theme.placeholderColor
        
        titleLabel.textColor = theme.subtitleColor
        
        textLabel.textColor = theme.bodyColor
        
        return self
        
    }
    
}
