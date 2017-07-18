//
//  LabelComponentView.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - LabelComponentView

import UIKit
import TinyCore

class LabelComponentView: UIView, Identifiable {

    // MARK: Property

    let label = UILabel()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpLabel()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setUpLabel()

    }

    // MARK: Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()

        label.frame = bounds

    }

    // MARK: Set Up

    fileprivate func setUpLabel() {

        addSubview(label)

    }

}
