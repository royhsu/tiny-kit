//
//  TSStoreItemView.swift
//  TinyStore
//
//  Created by Roy Hsu on 12/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSStoreItemView

// NOTE: The source code of the included third-party library ShadowView is modified. The rendering priorty gets higher from .utilities to .userinteractive.
// Beware of this if the library needs to be updated.

// TODO: measure the performance impact while rending preview image with a shadow.
public final class TSStoreItemView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var shadowView: ShadowView!

    @IBOutlet
    public fileprivate(set) final var previewImageView: UIImageView!

    @IBOutlet
    public fileprivate(set) final var titleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final var subtitleLabel: UILabel!

    // MARK: Life Cycle

    public final override func awakeFromNib() {

        setUpShadowView(shadowView)

        setUpPreviewImageView(previewImageView)

        setUpTitleLabel(titleLabel)

        setUpSubtitleLabel(subtitleLabel)

    }

    // MARK: Set Up

    fileprivate final func setUpShadowView(_ shadowView: ShadowView) {

        shadowView.shadowRadius = 4.0

        shadowView.shadowOffset = CGSize(
            width: 0.0,
            height: 4.5
        )

    }

    fileprivate final func setUpPreviewImageView(_ imageView: UIImageView) {

        imageView.layer.cornerRadius = 4.0

        imageView.contentMode = .scaleAspectFill

        imageView.clipsToBounds = true

    }

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 2

        label.font = UIFont.systemFont(
            ofSize: 13.0,
            weight: .medium
        )

        label.textColor = .black

    }

    fileprivate final func setUpSubtitleLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 1

        label.font = UIFont.systemFont(
            ofSize: 13.0,
            weight: .medium
        )

        label.textColor = .lightGray

    }

}
