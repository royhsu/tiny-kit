//
//  UIPrimaryButton+Theme.swift
//  TinyUI
//
//  Created by Roy Hsu on 20/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public extension UIPrimaryButton {
    
    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UIPrimaryButton {
        
        backgroundColor = theme.primaryColor
        
        titleLabel.textColor = theme.backgroundColor
        
        iconImageView.tintColor = theme.backgroundColor
        
        return self
        
    }
    
}
