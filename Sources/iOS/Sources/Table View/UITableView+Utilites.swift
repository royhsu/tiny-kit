//
//  UITableView+Utilites.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/4.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Scroll

public extension UITableView {
    
    func scrollToBottom(animated: Bool) {
        
        if numberOfSections == 0 { return }
        
        let lastSection = max(0, numberOfSections - 1)
        
        let rows = numberOfRows(inSection: lastSection)
        
        if rows == 0 { return }
        
        let lastRow = max(0, rows - 1)
        
        let lastIndexPath = IndexPath(
            row: lastRow,
            section: lastSection
        )
        
        scrollToRow(
            at: lastIndexPath,
            at: .bottom,
            animated: animated
        )
        
    }
    
}
