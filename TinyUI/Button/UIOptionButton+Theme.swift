//
//  UIOptionButton+Theme.swift
//  TinyUI
//
//  Created by Roy Hsu on 20/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public extension UIOptionButton {
    
    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UIOptionButton {
        
        backgroundColor = theme.backgroundColor
        
        titleLabel.textColor = theme.primaryColor
        
        return self
        
    }
    
}
