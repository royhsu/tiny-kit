//
//  UITableView+Register.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Register

import TinyCore

extension UITableView {

    public final func registerCell<Cell>(_ cellType: Cell.Type)
    where
        Cell: UITableViewCell,
        Cell: Reusable {

        register(
            cellType,
            forCellReuseIdentifier: cellType.reuseIdentifier
        )

    }

    public final func registerCell<Cell>(
        _ cellType: Cell.Type,
        nibIn bundle: Bundle?
    )
    where
        Cell: UITableViewCell,
        Cell: Reusable {

        let nib = UINib(
            nibName: cellType.reuseIdentifier,
            bundle: bundle
        )

        register(
            nib,
            forCellReuseIdentifier: cellType.reuseIdentifier
        )

    }

}
