//
//  UITableView+Dequeue.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Dequeue

import TinyCore

public extension UITableView {

    public final func dequeueCell<Cell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    )
    -> Cell
    where
        Cell: UITableViewCell,
        Cell: Reusable {

        guard
            let cell = dequeueReusableCell(
                withIdentifier: cellType.reuseIdentifier,
                for: indexPath
            ) as? Cell
        else { fatalError("Please make sure to register \(cellType) before dequeuing one.") }

        return cell

    }

}
