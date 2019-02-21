//
//  UICollectionView+Register.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Register

public extension UICollectionView {

    public final func registerCell<Cell>(_ cellType: Cell.Type)
    where
        Cell: UICollectionViewCell,
        Cell: Reusable {

        register(
            cellType,
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )

    }

    public final func registerCell<Cell>(
        _ cellType: Cell.Type,
        bundle: Bundle?
    )
    where
        Cell: UICollectionViewCell,
        Cell: Reusable,
        Cell: NibCell {

        let nib = UINib(
            nibName: cellType.nibName,
            bundle: bundle
        )

        register(
            nib,
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )

    }

}
