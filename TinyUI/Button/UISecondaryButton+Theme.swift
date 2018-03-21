//
//  UISecondaryButton+Theme.swift
//  TinyUI
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public extension UISecondaryButton {
    
    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UISecondaryButton {
        
        backgroundColor = theme.primaryColor
        
        titleLabel.textColor = theme.backgroundColor
        
        return self
        
    }
    
}
