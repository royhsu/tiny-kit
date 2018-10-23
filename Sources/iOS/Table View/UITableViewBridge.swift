//
//  UITableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewBridge

import UIKit

public final class UITableViewBridge: UITableViewController, UITableViewDataSourcePrefetching {

    public typealias NumberOfSections = (_ tableView: UITableView) -> Int

    public typealias NumberOfRows = (
        _ tableView: UITableView,
        _ section: Int
    )
    -> Int

    public typealias CellForRow = (
        _ tableView: UITableView,
        IndexPath
    )
    -> UITableViewCell

    public typealias PrefetchingForRows = (
        _ tableView: UITableView,
        [IndexPath]
    )
    -> Void

    private final var _numberOfSections: NumberOfSections?

    private final var _numberOfRows: NumberOfRows?

    private final var _cellForRow: CellForRow?

    private final var _prefetchingForRows: PrefetchingForRows?

    public init() { super.init(style: .plain) }
    
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    public final func setNumberOfSections(_ provider: NumberOfSections?) { _numberOfSections = provider }

    public final func setNumberOfRows(_ provider: NumberOfRows?) { _numberOfRows = provider }

    public final func setCellForRow(_ provider: CellForRow?) { _cellForRow = provider }

    public final func setPrefetchingForRows(_ provider: PrefetchingForRows?) { _prefetchingForRows = provider }
    
    // MARK: UITableViewDataSource

    public final override func numberOfSections(in tableView: UITableView) -> Int {

        let sections = _numberOfSections?(tableView)

        return sections ?? 1

    }

    public final override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {

        let rows = _numberOfRows?(
            tableView,
            section
        )

        return rows ?? 0

    }

    public final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {

        guard
            let cell = _cellForRow?(
                tableView,
                indexPath
            )
        else { fatalError("Cannot dequeue a cell from the given index path: \(indexPath)") }

        return cell

    }
    
    // MARK: UITableViewDataSourcePrefetching

    public final func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]
    ) {

        _prefetchingForRows?(
            tableView,
            indexPaths
        )

    }

}
