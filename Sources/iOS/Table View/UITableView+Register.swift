//
//  UITableView+Register.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Register

public extension UITableView {

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
        bundle: Bundle?
    )
    where
        Cell: UITableViewCell,
        Cell: Reusable,
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
