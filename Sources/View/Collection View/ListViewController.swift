//
//  ListViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListViewController

#if canImport(UIKit)

internal final class ListViewController: UITableViewController {
    
    internal final var bridge = UITableViewBridge()
    
    internal final override func numberOfSections(in tableView: UITableView) -> Int { return bridge.numberOfSections(tableView) }
    
    internal final override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {
        
        return bridge.numberOfRows(
            tableView,
            section
        )
            
    }
    
    internal final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        return bridge.cellForRow(
            tableView,
            indexPath
        )
        
    }
    
}

#endif
