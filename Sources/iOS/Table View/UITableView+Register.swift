//
//  UITableView+Register.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Register

import UIKit

public extension UITableView {

    public final func register<Cell>(_ cellType: Cell.Type)
    where
        Cell: UITableViewCell,
        Cell: ReusableCell {

        register(
            cellType,
            forCellReuseIdentifier: cellType.reuseIdentifier
        )

    }

    public final func register<Cell>(
        _ cellType: Cell.Type,
        bundle: Bundle?
    )
    where
        Cell: UITableViewCell,
        Cell: ReusableCell,
        Cell: NibCell {

        let nib = UINib(
            nibName: cellType.nibName,
            bundle: bundle
        )

        register(
            nib,
            forCellReuseIdentifier: cellType.reuseIdentifier
        )

    }

}
