//
//  UITableView+Dequeue.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Dequeue

import UIKit

public extension UITableView {

    public final func dequeueReusableCell<Cell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    )
    -> Cell
    where
        Cell: UITableViewCell,
        Cell: ReusableCell {

        guard
            let cell = dequeueReusableCell(
                withIdentifier: cellType.reuseIdentifier,
                for: indexPath
            ) as? Cell
        else { fatalError("Please make sure to register \(cellType) before dequeuing one.") }

        return cell

    }

}
