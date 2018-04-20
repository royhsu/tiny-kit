//
//  UICollectionView+Cell.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

// MARK: - Cell

import UIKit

public extension UICollectionView {

    /// Register a cell by its type.
    ///
    /// - Parameter type: The subclass of target UICollectionViewCell.
    ///
    public final func registerCell<Cell: UICollectionViewCell>(_ type: Cell.Type) {

        let typeName = String(describing: type)

        register(
            type.self,
            forCellWithReuseIdentifier: typeName
        )

    }

    /// Register a cell with the corresponding nib file.
    /// Please make sure that the file name mathes its type name.
    ///
    /// - Parameter type: The subclass of target UICollectionViewCell.
    /// - Parameter bundle: The bundle contains the nib file for the cell.
    ///
    public final func registerCell<Cell: UICollectionViewCell>(
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
            forCellWithReuseIdentifier: nibName
        )

    }

    /// Dequeue cell by the given indexPath.
    ///
    /// - Parameter type: The subclass of target UICollectionViewCell.
    /// - Parameter indexPath: The indexPath of the cell.
    ///
    /// - Returns: The target cell or nil.
    ///
    public final func dequeueReusableCell<Cell: UICollectionViewCell>(
        _ type: Cell.Type,
        for indexPath: IndexPath
    )
    -> Cell? {

        let typeName = String(describing: type)

        return dequeueReusableCell(
            withReuseIdentifier: typeName,
            for: indexPath
        ) as? Cell

    }

}
