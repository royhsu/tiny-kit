//
//  UIImageView+Theme.swift
//  TinyPost
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension UIImageView {

    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UIImageView {

        backgroundColor = theme.placeholderColor

        return self

    }

}
