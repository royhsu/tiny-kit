//
//  TableViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TableViewController

import UIKit
import TinyCore

open class TableViewController<Value>: UIViewController {
    
    private typealias Index = Int
    
    private final let tableView = UITableView()
    
    private final let dataSourceController = UITableViewDataSourceController()
    
    public final var storage: AnyStorage<Int, Value>? {
        
        didSet {
            
            guard
                let storage = storage
            else { return }
            
            let subscription = storage.keyDiff.subscribe { _ in
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    
                }
            }
            
            subscriptions = [ subscription ]
            
        }
        
    }
    
    private final var subscriptions: [ObservableSubscription] = []
    
    open override func loadView() { view = tableView }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = dataSourceController
        
        dataSourceController.setNumberOfSections { [weak self] _ in
            
            guard
                let maxKey = self?.storage?.maxKey
            else { return 0 }
            
            return maxKey + 1
            
        }
        
        dataSourceController.setNumberOfRows { _, _ in
            
            return 1
            
        }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            let cell = UITableViewCell()
            
            if
                let self = self,
                let value = self.storage?[indexPath.section] {
            
                self.configureCell(
                    cell,
                    with: value
                )
                
            }
            
            return cell
            
        }
        
    }
    
    // CellDescriptor.
    open func configureCell(
        _ cell: UITableViewCell,
        with value: Value
    ) { }
    
}
