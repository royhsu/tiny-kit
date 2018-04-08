//
//  UIProductDescriptionView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDescriptionView

public final class UIProductDescriptionView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final weak var subtitleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final weak var actionContainerView: UIView!

    public final override func awakeFromNib() {

        setUpTitleLabel(titleLabel)

        setUpSubtitleLabel(subtitleLabel)

        setUpActionContainerView(actionContainerView)

    }

    // MARK: Set Up

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 0

        label.font = UIFont.systemFont(
            ofSize: 15.0,
            weight: .medium
        )

        label.textColor = .black

    }

    fileprivate final func setUpSubtitleLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 2

        label.font = UIFont.systemFont(ofSize: 15.0)

        label.textColor = .lightGray

    }

    fileprivate final func setUpActionContainerView(_ view: UIView) { view.backgroundColor = nil }

}
