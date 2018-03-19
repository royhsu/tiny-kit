//
//  UINumberPicker+Theme.swift
//  TinyUI
//
//  Created by Roy Hsu on 19/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public extension UINumberPicker {
    
    public final func applyTheme(_ theme: Theme) {
        
        backgroundColor = theme.primaryColor
        
        increaseIconImageView.tintColor = theme.backgroundColor
        
        decreaseIconImageView.tintColor = theme.backgroundColor
        
        numberContainerView.backgroundColor = theme.backgroundColor
        
        numberTextField.textColor = theme.titleColor
        
    }
    
}
