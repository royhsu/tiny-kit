//
//  LargeTitleLabel.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LargeTitleLabel

import UIKit

public final class LargeTitleLabel: UILabel {

    public override init(frame: CGRect) {

        super.init(frame: frame)

        self.prepare()

    }

    public required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.prepare()

    }

    fileprivate final func prepare() {

        numberOfLines = 0

        font = .preferredFont(forTextStyle: .largeTitle)

    }

}
