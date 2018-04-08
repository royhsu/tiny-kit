//
//  UIPostParagraphView+Theme.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension UIPostParagraphView {
    
    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UIPostParagraphView {
        
        backgroundColor = theme.backgroundColor
        
        textLabel.textColor = theme.bodyColor
        
        return self
        
    }
    
}
