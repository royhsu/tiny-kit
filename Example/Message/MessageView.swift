//
//  MessageView.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MessageView

import UIKit

public final class MessageView: UIView {

    @IBOutlet
    public fileprivate(set) final weak var textLabel: UILabel!

    public final override func awakeFromNib() {

        setUpTextLabel(textLabel)

    }

    fileprivate final func setUpTextLabel(_ label: UILabel) {

        label.text = nil

        label.textAlignment = .center

        label.numberOfLines = 0

        label.font = .preferredFont(forTextStyle: .body)

    }

}
