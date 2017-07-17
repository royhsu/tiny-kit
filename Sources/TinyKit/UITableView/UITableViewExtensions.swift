//
//  UITableViewExtensions.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

#if os(iOS)

import TinyCore
import UIKit

public extension UITableView {

    // MARK: Register Cells

    /// Register an identifiable cell
    ///
    /// - parameter CellType: The subclass of target UITableViewCell. It must conform to the protocol Identifiable.
    ///

    func registerCell<Cell>(_ cellType: Cell.Type) where Cell: UITableViewCell, Cell: Identifiable {

        let reuseIdentifier = cellType.identifier

        register(
            cellType.self,
            forCellReuseIdentifier: reuseIdentifier
        )

    }

}

#endif
