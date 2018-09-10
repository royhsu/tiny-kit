//
//  UITableViewDataSourceController.swift
//  TinyKit Tests
//
//  Created by Roy Hsu on 2018/9/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewDataSourceController

import UIKit

public final class UITableViewDataSourceController: NSObject {
    
    public typealias NumberOfSectionsProvider = () -> Int
    
    public typealias NumberOfRowsProvider = (_ section: Int) -> Int
    
    public typealias CellForRowProvider = (IndexPath) -> UITableViewCell
    
    public final var numberOfSectionsProvider: NumberOfSectionsProvider?
    
    public final var numberOfRowsProvider: NumberOfRowsProvider?
    
    public final var cellForRowProvider: CellForRowProvider?
    
    public init(
        numberOfSectionsProvider: NumberOfSectionsProvider? = nil,
        numberOfRowsProvider: NumberOfRowsProvider? = nil,
        cellForRowProvider: CellForRowProvider? = nil
    ) {
        
        self.numberOfSectionsProvider = numberOfSectionsProvider
        
        self.numberOfRowsProvider = numberOfRowsProvider
        
        self.cellForRowProvider = cellForRowProvider
        
    }
    
}

// MARK: - UITableViewDataSource

extension UITableViewDataSourceController: UITableViewDataSource {
    
    public final func numberOfSections(in tableView: UITableView) -> Int { return numberOfSectionsProvider?() ?? 1 }
    
    public final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int { return numberOfRowsProvider?(section) ?? 0 }
    
    public final func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        guard
            let cell = cellForRowProvider?(indexPath)
        else { fatalError("Cannot dequeue a cell from the given index path: \(indexPath)") }
        
        return cell
        
    }
    
}
