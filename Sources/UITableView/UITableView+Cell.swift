//
//  UITableView+Cell.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - Cell

import UIKit

public extension UITableView {

    /// Register a cell by its type.
    ///
    /// - parameter type: The subclass of target UITableViewCell.
    ///
    public final func registerCell<Cell: UITableViewCell>(_ type: Cell.Type) {

        let typeName = String(describing: type)

        register(
            type.self,
            forCellReuseIdentifier: typeName
        )

    }

    /// Register a cell with the corresponding nib file.
    /// Please make sure that the file name matches its type name.
    ///
    /// - parameter type: The subclass of target UITableViewCell.
    /// - parameter bundle: The bundle contains the nib file for the cell.
    ///
    public final func registerCell<Cell: UITableViewCell>(
        _ type: Cell.Type,
        withNibFrom bundle: Bundle
    ) {

        let nibName = String(describing: type)

        let nib = UINib(
            nibName: nibName,
            bundle: bundle
        )

        register(
            nib,
            forCellReuseIdentifier: nibName
        )

    }

    /// Dequeue a cell by the given indexPath.
    ///
    /// - parameter type: The subclass of target UITableViewCell.
    /// - parameter indexPath: The indexPath of the cell.
    ///
    /// - Returns: The target cell or nil.
    ///
    public final func dequeueReusableCell<Cell: UITableViewCell>(
        _ type: Cell.Type,
        for indexPath: IndexPath
    )
    -> Cell? {

        let typeName = String(describing: type)

        return dequeueReusableCell(
            withIdentifier: typeName,
            for: indexPath
        ) as? Cell

    }

}
