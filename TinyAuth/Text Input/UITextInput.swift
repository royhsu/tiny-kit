//
//  UITextInput.swift
//  TinyAuth
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITextInput

import UIKit

public final class UITextInput: UIView {

    @IBOutlet
    public fileprivate(set) weak var titleLabel: UILabel!

    @IBOutlet
    public fileprivate(set) weak var inputTextField: UITextField!

    // MARK: Life Cycle

    public final override func awakeFromNib() {

        setUpTitleLabel(titleLabel)

        setUpInputTextField(inputTextField)

    }

    // MARK: Set Up

    fileprivate final func setUpTitleLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .right

        label.font = .preferredFont(forTextStyle: .subheadline)

    }

    fileprivate final func setUpInputTextField(_ textField: UITextField) { }

}
