//
//  UITableViewExtensions.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

#if os(iOS)

import UIKit
import TinyCore

public extension UITableView {

    // MARK: Register Cells

    /// Register an identifiable cell.
    ///
    /// - parameter cellType: The subclass of target UITableViewCell. It must conform to the protocol `Identifiable`.
    ///
    func registerCell<Cell>(_ cellType: Cell.Type) where Cell: UITableViewCell, Cell: Identifiable {

        let reuseIdentifier = cellType.identifier

        register(
            cellType.self,
            forCellReuseIdentifier: reuseIdentifier
        )

    }

    /// Register an identifiable cell with the corresponding nib file.
    /// Please make sure to the reuse identifier in the nib file match the one provided by `Identifiable` protocol.
    ///
    /// - parameter cellType: The subclass of target UITableViewCell. It must conform to the protocol `Identifiable`.
    /// - parameter bundle: The bundle contains the nib file for the cell.
    ///
    // swiftlint:disable line_length
    func registerCell<Cell>(_ cellType: Cell.Type, withNibIn bundle: Bundle) where Cell: UITableViewCell, Cell: Identifiable {

        let reuseIdentifier = cellType.identifier

        let nib = UINib(
            nibName: reuseIdentifier,
            bundle: bundle
        )

        register(
            nib,
            forCellReuseIdentifier: reuseIdentifier
        )

    }
    // swiftlint:enable line_length

}

#endif
