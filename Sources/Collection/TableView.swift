//
//  TableView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TableView

#if canImport(UIKit)

import UIKit

public typealias TableView = UITableView

#else

public final class TableView: View {
    
    public final func reloadData() { }
    
}

#endif
