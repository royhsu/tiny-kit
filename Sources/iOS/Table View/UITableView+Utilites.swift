//
//  UITableView+Utilites.swift
//  TinyKit
//
//  Created by Roy Hsu on 2019/2/4.
//  Copyright © 2019 TinyWorld. All rights reserved.
//

// MARK: - Scroll

public extension UITableView {
    
    public func scrollToBottom(animated: Bool) {
        
        let lastSection = numberOfSections - 1
        
        let rows = numberOfRows(inSection: lastSection)
        
        let lastRow = rows - 1
        
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
