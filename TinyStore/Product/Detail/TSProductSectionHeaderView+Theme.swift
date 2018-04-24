//
//  TSProductSectionHeaderView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 22/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public extension TSProductSectionHeaderView {

    public final func applyTheme(_ theme: Theme) {

        backgroundColor = theme.backgroundColor

        iconImageView.tintColor = theme.titleColor

        titleLabel.textColor = theme.titleColor

    }

}
