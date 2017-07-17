//
//  UITableViewExtensions.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/07/2017.
//
//

#if os(iOS)

import TinyCore
import UIKit

public extension UITableView {
    
    func registerCell<Cell>(_ CellType: Cell.Type) where Cell: UITableViewCell, Cell: Identifiable {
        
        let reuseIdentifier = CellType.identifier
        
        register(
            CellType.self,
            forCellReuseIdentifier: reuseIdentifier
        )
    
    }
    
}

#endif
