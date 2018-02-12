//
//  PostView.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostView

import UIKit

public final class PostView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final weak var contentLabel: UILabel!

    // MARK: Life Cycle

    public final override func awakeFromNib() {

        setUpTitleLabel(titleLabel)

        setUpContentLabel(contentLabel)

    }

    // MARK: Set Up

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.text = nil

        label.font = .preferredFont(forTextStyle: .title3)

        label.numberOfLines = 1

    }

    fileprivate final func setUpContentLabel(_ label: UILabel) {

        label.text = nil

        label.textColor = .darkGray

        label.font = .preferredFont(forTextStyle: .body)

        label.numberOfLines = 0

    }

}
