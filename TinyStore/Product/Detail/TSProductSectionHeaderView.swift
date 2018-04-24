//
//  TSProductSectionHeaderView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductSectionHeaderView

public final class TSProductSectionHeaderView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var iconImageView: UIImageView!

    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!

    // MARK: Life Cycle

    public final override func awakeFromNib() {

        setUpIconImageView(iconImageView)

        setUpTitleLabel(titleLabel)

    }

    // MARK: Set Up

    fileprivate final func setUpIconImageView(_ imageView: UIImageView) {

        imageView.tintColor = .black

        imageView.contentMode = .scaleAspectFill

    }

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.numberOfLines = 1

        label.font = .systemFont(
            ofSize: 10.0,
            weight: .medium
        )

        label.text = nil

        label.textColor = .black

        label.textAlignment = .left

    }

}
