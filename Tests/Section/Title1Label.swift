//
//  TitleLabel.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TitleLabel

import TinyKit

internal final class Title1Label: UILabel {

    internal override init(frame: CGRect) {

        super.init(frame: frame)

        self.prepare()

    }

    internal required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.prepare()

    }

    fileprivate final func prepare() {

        numberOfLines = 0

        font = UIFont.preferredFont(forTextStyle: .title3)

    }

}
