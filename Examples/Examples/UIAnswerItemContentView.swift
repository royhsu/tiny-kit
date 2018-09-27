//
//  UIAnswerItemContentView.swift
//  TinyKnowledge
//
//  Created by Roy Hsu on 2018/7/3.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAnswerItemContentView

import UIKit

internal final class UIAnswerItemContentView: UIView {

    @IBOutlet
    internal fileprivate(set) final weak var userPictureImageView: UIImageView!

    @IBOutlet
    internal fileprivate(set) final weak var userNameLabel: UILabel!

    @IBOutlet
    internal fileprivate(set) final weak var voteContainerView: UIView!

    @IBOutlet
    internal fileprivate(set) final weak var bodyLabel: UILabel!

    internal final override func awakeFromNib() {

        super.awakeFromNib()

        prepare()

    }

    internal final override func layoutSubviews() {

        super.layoutSubviews()

        userPictureImageView.layer.cornerRadius = userPictureImageView.bounds.width / 2.0

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        layer.cornerRadius = 2.0

        let textColor = UIColor(
            red: 6.0 / 255.0,
            green: 0.0,
            blue: 23.0 / 255.0,
            alpha: 1.0
        )

        userNameLabel.textColor = textColor

        bodyLabel.textColor = textColor

        userPictureImageView.clipsToBounds = true

        userPictureImageView.contentMode = .scaleAspectFill

        userPictureImageView.layer.borderWidth = 0.5

        userPictureImageView.layer.borderColor = UIColor.darkGray.cgColor

    }

}
