//
//  UIPostParagraphView.swift
//  TinyPost
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostParagraphView

public final class UIPostParagraphView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var textLabel: UILabel!

    public final override func awakeFromNib() {

        setUpTextLabel(textLabel)

    }

    // MARK: Set Up

    fileprivate final func setUpTextLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .left

        label.numberOfLines = 0

        label.font = .systemFont(ofSize: 14.0)

        label.textColor = .black

    }

}
