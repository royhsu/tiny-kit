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

open class TableViewController<S: Storage>: UIViewController where S.Key == Int {
    
    private typealias Index = Int
    
    private final let tableView = UITableView()
    
    private final let dataSourceController = UITableViewDataSourceController()
    
    public final var storage: S? {
        
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
            print("setNumberOfSections:", self?.storage?.maxKey)
            guard
                let maxKey = self?.storage?.maxKey
            else { return 0 }
            
            return maxKey + 1
            
        }
        
        dataSourceController.setNumberOfRows { _, _ in
            print("setNumberOfRows:", self.storage)
            return 1
            
        }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            print("setCellForRow:", self?.storage)
            let cell = UITableViewCell()
            
            let element = self?.storage?[indexPath.section]
            
            cell.textLabel?.text = "\(indexPath)"
            
            return cell
            
        }
        
        // Trigger fetching manually.
        // TODO: add a fetchController to interpolate storage.
        storage?[0]
        
    }
    
}
