//
//  UITableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewBridge

internal final class UITableViewBridge: NSObject {
    
    internal final let cellIdentifier: String
    
    internal final var dataSource: ListComponentDataSource?
    
    internal init(cellIdentifier: String) { self.cellIdentifier = cellIdentifier }
    
}

extension UITableViewBridge: UITableViewDataSource {
    
    internal final func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource?.numberOfSections() ?? 0
        
    }
    
    internal final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {
        
        return dataSource?.numberOfItemsAtSection(section) ?? 0
        
    }
    
    internal final func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        )
        
        cell.selectionStyle = .none
        
        cell.backgroundColor = .clear
        
        if let component = dataSource?.componentForItem(at: indexPath) {
            
            component.render()
            
            cell.contentView.render(with: component)
            
        }
        
        return cell
            
    }
    
}

// MARK: - UITableViewDelegate

extension UITableViewBridge: UITableViewDelegate {
    
    internal final func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat {
        
        guard
            let component = dataSource?.componentForItem(at: indexPath)
        else { return 0.0 }
        
        switch component.contentMode {
            
        case .size(_, let height): return height
            
        case .automatic: return UITableViewAutomaticDimension
            
        }
            
    }
    
}
