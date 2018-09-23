//
//  TableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TableViewBridge

#if canImport(UIKit)

public typealias TableViewBridge = UITableViewBridge

#else

#error("No bridge for the current platform.")

#endif
