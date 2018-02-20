//
//  UIMessageView.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 20/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIMessageView

import UIKit

public final class UIMessageView: UIView {

    @IBOutlet
    public fileprivate(set) weak var titleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) weak var textLabel: UILabel!

    // MARK: Life Cycle

    public final override func awakeFromNib() {

        setUpTitleLabel(titleLabel)

        setUpTextLabel(textLabel)

    }

    // MARK: Set Up

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.text = nil

        label.font = UIFont.preferredFont(forTextStyle: .title1)

        label.textAlignment = .center

    }

    fileprivate final func setUpTextLabel(_ label: UILabel) {

        label.text = nil

        label.font = UIFont.preferredFont(forTextStyle: .body)

        label.textAlignment = .center

    }

}
