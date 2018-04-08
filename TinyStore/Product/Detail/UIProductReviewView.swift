//
//  UIProductReviewView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductReviewView

public final class UIProductReviewView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var pictureImageView: UIImageView!

    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final weak var textLabel: UILabel!

    // MARK: Life Cycle

    public final override func awakeFromNib() {

        setUpRootView(self)

        setUpPictureImageView(pictureImageView)

        setUpTitleLabel(titleLabel)

        setUpTextLabel(textLabel)

    }

    public final override func layoutSubviews() {

        pictureImageView.layer.cornerRadius = pictureImageView.bounds.width / 2.0

    }

    // MARK: Set Up

    fileprivate final func setUpRootView(_ view: UIView) {

        view.layer.shadowColor = UIColor.black.cgColor

        view.layer.shadowOffset = CGSize(
            width: 0.0,
            height: 2.0
        )

        view.layer.shadowOpacity = 0.15

        view.layer.shadowRadius = 5.0

    }

    fileprivate final func setUpPictureImageView(_ imageView: UIImageView) {

        imageView.contentMode = .scaleAspectFill

        imageView.clipsToBounds = true

        imageView.backgroundColor = .lightGray

    }

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.textAlignment = .left

        label.text = nil

        label.textColor = .lightGray

        label.numberOfLines = 1

        label.font = .systemFont(ofSize: 14.0)

    }

    fileprivate final func setUpTextLabel(_ label: UILabel) {

        label.textAlignment = .left

        label.text = nil

        label.textColor = .black

        label.numberOfLines = 0

        label.font = .systemFont(ofSize: 14.0)

    }

}
