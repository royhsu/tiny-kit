//
//  UITableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewBridge

import UIKit

public final class UITableViewBridge: NSObject {

    public typealias NumberOfSections = (UITableView) -> Int

    public typealias NumberOfRows = (
        UITableView,
        _ section: Int
    )
    -> Int

    public typealias CellForRow = (
        UITableView,
        IndexPath
    )
    -> UITableViewCell
    
    public typealias PrefetchingForRows = (
        UITableView,
        [IndexPath]
    )
    -> Void
    
    private final var numberOfSections: NumberOfSections?

    private final var numberOfRows: NumberOfRows?

    private final var cellForRow: CellForRow?
    
    private final var prefetchingForRows: PrefetchingForRows?

    public init(
        numberOfSections: NumberOfSections? = nil,
        numberOfRows: NumberOfRows? = nil,
        cellForRow: CellForRow? = nil,
        prefetchingForRows: PrefetchingForRows? = nil
    ) {

        self.numberOfSections = numberOfSections

        self.numberOfRows = numberOfRows

        self.cellForRow = cellForRow
        
        self.prefetchingForRows = prefetchingForRows

    }
    
    public final func setNumberOfSections(_ provider: NumberOfSections?) { numberOfSections = provider }

    public final func setNumberOfRows(_ provider: NumberOfRows?) { numberOfRows = provider }
    
    public final func setCellForRow(_ provider: CellForRow?) { cellForRow = provider }
    
    public final func setPrefetchingForRows(_ provider: PrefetchingForRows?) { prefetchingForRows = provider }
    
}

// MARK: - UITableViewDataSource

extension UITableViewBridge: UITableViewDataSource {

    public final func numberOfSections(in tableView: UITableView) -> Int {
        
        let sections = numberOfSections?(tableView)
        
        return sections ?? 1
        
    }

    public final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {
        
        let rows = numberOfRows?(
            tableView,
            section
        )
        
        return rows ?? 0
        
    }

    public final func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        guard
            let cell = cellForRow?(
                tableView,
                indexPath
            )
        else { fatalError("Cannot dequeue a cell from the given index path: \(indexPath)") }

        return cell

    }

}

// MARK: - UITableViewDataSourcePrefetching

extension UITableViewBridge: UITableViewDataSourcePrefetching {
    
    public final func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]
    ) {
        
        prefetchingForRows?(
            tableView,
            indexPaths
        )
        
    }
    
}
