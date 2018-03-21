//
//  UICheckboxItem.swift
//  TinyUI
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public extension UICheckbox {
    
    public final func applyTheme(_ theme: Theme) {
        
        iconImageView.tintColor = theme.primaryColor
        
        backgroundColor = theme.backgroundColor
        
    }
    
}
