//
//  TSProductDescriptionView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductDescriptionView

public final class TSProductDescriptionView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final weak var subtitleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final weak var buttonContainerView: UIView!

    public final override func awakeFromNib() {

        setUpTitleLabel(titleLabel)

        setUpSubtitleLabel(subtitleLabel)

        setUpButtonContainerView(buttonContainerView)

    }

    // MARK: Set Up

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 0

        label.font = .systemFont(
            ofSize: 15.0,
            weight: .medium
        )

        label.textColor = .black

    }

    fileprivate final func setUpSubtitleLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 2

        label.font = .systemFont(ofSize: 15.0)

        label.textColor = .lightGray

    }

    fileprivate final func setUpButtonContainerView(_ view: UIView) { view.backgroundColor = nil }

}
