//
//  UICollectionView+Dequeue.swift
//  TinyKit iOS
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Dequeue

import TinyCore

public extension UICollectionView {

    public final func dequeueCell<Cell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    )
    -> Cell
    where
        Cell: UICollectionViewCell,
        Cell: Reusable {

        guard
            let cell = dequeueReusableCell(
                withReuseIdentifier: cellType.reuseIdentifier,
                for: indexPath
            ) as? Cell
        else { fatalError("Please make sure to register \(cellType) before dequeuing one.") }

        return cell

    }

}
