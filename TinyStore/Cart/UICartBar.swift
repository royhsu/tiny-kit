//
//  UICartBar.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartBar

public final class UICartBar: UIView {

    @IBOutlet
    public fileprivate(set) final weak var amountLabel: UILabel!

    @IBOutlet
    public fileprivate(set) final weak var actionContainerView: UIView!

    public final override func awakeFromNib() {

        setUpActionContainerView(actionContainerView)

    }

    // MARK: Set Up

    fileprivate final func setUpActionContainerView(_ view: UIView) {

        view.backgroundColor = nil

    }

}
