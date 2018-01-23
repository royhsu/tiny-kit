//
//  UICollectionViewExtensions.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

#if os(iOS)

import UIKit
import TinyCore

public extension UICollectionView {

    // MARK: Register Cells

    /// Register an identifiable cell.
    ///
    /// - parameter cellType: The subclass of target UICollectionViewCell. It must conform to the protocol `Identifiable`.
    ///
//    public func registerCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type) where Cell: Identifiable {
//
//        let reuseIdentifier = cellType.identifier
//
//        register(
//            cellType.self,
//            forCellWithReuseIdentifier: reuseIdentifier
//        )
//
//    }

    /// Register an identifiable cell with the corresponding nib file.
    /// Please make sure to the reuse identifier in the nib file match the one provided by `Identifiable` protocol.
    ///
    /// - parameter cellType: The subclass of target UICollectionViewCell. It must conform to the protocol `Identifiable`.
    /// - parameter bundle: The bundle contains the nib file for the cell.
    ///
    // swiftlint:disable line_length
//    public func registerCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type, withNibFrom bundle: Bundle) where Cell: Identifiable {
//
//        let reuseIdentifier = cellType.identifier
//
//        let nib = UINib(
//            nibName: reuseIdentifier,
//            bundle: bundle
//        )
//
//        register(
//            nib,
//            forCellWithReuseIdentifier: reuseIdentifier
//        )
//
//    }
    // swiftlint:enable line_length

    // MARK: Dequeue Reusable Cells

    /// Dequeue an identifiable cell by indexPath.
    ///
    /// - parameter indexPath: The indexPath of the cell.
    ///
    /// - Returns: A target cell or nil.
    ///
//    public func dequeueReusableCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell? where Cell: Identifiable {
//
//        let identifier = Cell.identifier
//
//        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
//
//    }

}

#endif
