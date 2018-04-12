//
//  TSProductDescriptionView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension TSProductDescriptionView {

    public final func applyTheme(_ theme: Theme) {

        backgroundColor = theme.backgroundColor

        titleLabel.textColor = theme.titleColor

        subtitleLabel.textColor = theme.subtitleColor

    }

}
