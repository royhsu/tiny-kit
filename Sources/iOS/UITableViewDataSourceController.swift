//
//  UITableViewDataSourceController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewDataSourceController

import UIKit

public final class UITableViewDataSourceController: NSObject {

    public typealias NumberOfSectionsProvider = (UITableView) -> Int

    public typealias NumberOfRowsProvider = (
        UITableView,
        _ section: Int
    )
    -> Int

    public typealias CellForRowProvider = (
        UITableView, IndexPath
    )
    -> UITableViewCell

    private final var numberOfSectionsProvider: NumberOfSectionsProvider?

    private final var numberOfRowsProvider: NumberOfRowsProvider?

    private final var cellForRowProvider: CellForRowProvider?

    public init(
        numberOfSectionsProvider: NumberOfSectionsProvider? = nil,
        numberOfRowsProvider: NumberOfRowsProvider? = nil,
        cellForRowProvider: CellForRowProvider? = nil
    ) {

        self.numberOfSectionsProvider = numberOfSectionsProvider

        self.numberOfRowsProvider = numberOfRowsProvider

        self.cellForRowProvider = cellForRowProvider

    }
    
    public final func setNumberOfSections(provider: NumberOfSectionsProvider?) { numberOfSectionsProvider = provider }

    public final func setNumberOfRows(provider: NumberOfRowsProvider?) { numberOfRowsProvider = provider }
    
    public final func setCellForRow(provider: CellForRowProvider?) { cellForRowProvider = provider }
    
}

// MARK: - UITableViewDataSource

extension UITableViewDataSourceController: UITableViewDataSource {

    public final func numberOfSections(in tableView: UITableView) -> Int {
        
        let sections = numberOfSectionsProvider?(tableView)
        
        return sections ?? 1
        
    }

    public final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {
        
        let rows = numberOfRowsProvider?(
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
            let cell = cellForRowProvider?(
                tableView,
                indexPath
            )
        else { fatalError("Cannot dequeue a cell from the given index path: \(indexPath)") }

        return cell

    }

}
