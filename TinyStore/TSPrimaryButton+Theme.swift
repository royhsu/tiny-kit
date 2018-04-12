//
//  TSPrimaryButton+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 20/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public extension TSPrimaryButton {

    public final func applyTheme(_ theme: Theme) {

        backgroundColor = theme.primaryColor

        titleLabel.textColor = theme.backgroundColor

        iconImageView.tintColor = theme.backgroundColor

    }

}
