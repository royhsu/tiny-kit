//
//  TSProductGalleryView+Theme.swift
//  TinyStore
//
//  Created by Roy Hsu on 21/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

import TinyUI

public extension TSProductGalleryContainerView {

    public final func applyTheme(_ theme: Theme) {

        backgroundColor = theme.backgroundColor

        triangleView.triangleColor = theme.backgroundColor

    }

}
