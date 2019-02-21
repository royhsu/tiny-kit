//
//  UITableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewBridge

internal struct UITableViewBridge {
    
    internal var numberOfSections: (UITableView) -> Int = { _ in 1 }
    
    internal var numberOfRows: (UITableView, _ section: Int) -> Int = { _, _ in 0 }
    
    internal var cellForRow: (UITableView, IndexPath) -> UITableViewCell = { _, _ in UITableViewCell() }
    
}
