//
//  TableView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TableView

#if canImport(UIKit)

import UIKit

public final class TableView: UITableView {

    public final var bridge: TableViewBridge? {

        didSet {

            dataSource = bridge

            prefetchDataSource = bridge

        }

    }

}

#else

public final class TableView: View {

    public final var bridge: TableViewBridge?

    public final func registerCell<Cell>(_ cellType: Cell.Type)
    where
        Cell: TableViewCell,
        Cell: ReusableCell { fatalError("Not implemented.") }

    public final func registerCell<Cell>(
        _ cellType: Cell.Type,
        bundle: Bundle?
    )
    where
        Cell: TableViewCell,
        Cell: ReusableCell,
        Cell: NibCell { fatalError("Not implemented.") }

    func dequeueCell<Cell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    )
    -> Cell
    where
        Cell: TableViewCell,
        Cell: ReusableCell { fatalError("Not implemented.") }

    public final func reloadData() { fatalError("Not implemented.") }

}

#endif
