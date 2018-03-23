//
//  UIGridItemView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension UIGridItemView {
    
    public final func applyTheme(_ theme: Theme) {
        
        titleLabel.textColor = theme.titleColor
    
        subtitleLabel.textColor = theme.subtitleColor
        
        previewImageView.backgroundColor = theme.placeholderColor
        
    }
    
}
