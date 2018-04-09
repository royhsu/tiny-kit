//
//  UIProductSectionHeaderView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension UIProductSectionHeaderView {

    @discardableResult
    public final func applyTheme(_ theme: Theme) -> UIProductSectionHeaderView {

        backgroundColor = theme.backgroundColor

        iconImageView.tintColor = theme.titleColor

        titleLabel.textColor = theme.titleColor

        return self

    }

}
