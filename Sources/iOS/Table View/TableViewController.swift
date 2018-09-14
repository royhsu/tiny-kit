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

public protocol Updatable {
    
    func updateValue(_ value: Any?)
    
}

open class TableViewController<T: Template, Value>: UIViewController where Value: Equatable {

    private final class Cell: UITableViewCell, ReusableCell { }
    
    private final let tableView = UITableView()
    
    public final var template: T? {
        
        didSet {
            
            if isViewLoaded {
                
                DispatchQueue.main.async { self.tableView.reloadData() }
                
            }
            
        }
        
    }
    
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
        
        tableView.separatorStyle = .none
        
        tableView.register(Cell.self)
        
        tableView.dataSource = dataSourceController
        
        dataSourceController.setNumberOfSections { [weak self] _ in
            
            guard
                let maxKey = self?.storage?.maxKey
            else { return 0 }

            return maxKey + 1
            
        }
        
        dataSourceController.setNumberOfRows { [weak self] _, _ in self?.template?.numberOfElements ?? 0 }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            guard
                let self = self,
                let element = self.template?.element(at: indexPath.row),
                let view = self.template?.view(for: element)
            else { return UITableViewCell() }
            
            let cell = self.tableView.dequeueReusableCell(
                Cell.self,
                for: indexPath
            )
            
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            cell.contentView.wrapSubview(view)
            
            let value = self.storage?[indexPath.section]
            
            let updatable = view as? Updatable
            
            updatable?.updateValue(value)
            
            return cell
            
        }
        
    }
    
}

