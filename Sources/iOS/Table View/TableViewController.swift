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

open class TableViewController<C>: UIViewController
where C: SectionCollection {
    
    public typealias Storage = C.Item.Storage
    
    public typealias Reducer = (Storage) -> C
    
    private final class Cell: UITableViewCell, ReusableCell { }
    
    private final let tableView = UITableView()
    
    private final var sections: C? {
        
        didSet {
            
            if isViewLoaded { asyncReloadTableView() }
            
        }
        
    }
    
    private final let dataSourceController = UITableViewDataSourceController()
    
    public final var storage: Storage? {
        
        didSet {
            
            guard
                let storage = storage
            else { return }
            
            let subscription = storage.keyDiff.subscribe { _ in
                
                self.asyncReloadTableView()
                
            }
            
            subscriptions = [ subscription ]
            
            reduceStorage()
            
        }
        
    }
    
    public final var reducer: Reducer? {
        
        didSet { reduceStorage() }
        
    }
    
    fileprivate final func reduceStorage() {
        
        DispatchQueue.main.async { [weak self] in
            
            guard
                let self = self,
                let storage = self.storage,
                let reducer = self.reducer
            else { return }
            
            self.sections = reducer(storage)
            
        }
        
    }
    
    fileprivate final func asyncReloadTableView() {
        
        DispatchQueue.main.async { [weak self] in self?.tableView.reloadData() }
        
    }
    
    private final var subscriptions: [ObservableSubscription] = []
    
    open override func loadView() { view = tableView }
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        tableView.register(Cell.self)
        
        tableView.dataSource = dataSourceController
        
        dataSourceController.setNumberOfSections { [weak self] _ in self?.sections?.numberOfItems ?? 0 }
        
        dataSourceController.setNumberOfRows { [weak self] _, section in
            
            let section = self?.sections?.item(at: section)
            
            return section?.numberOfElements ?? 0
            
        }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            guard
                let self = self,
                let section = self.sections?.item(at: indexPath.section)
            else { return UITableViewCell() }
            
            let view = section.view(at: indexPath.row)
            
            let cell = self.tableView.dequeueReusableCell(
                Cell.self,
                for: indexPath
            )
            
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            cell.contentView.wrapSubview(view)
            
            return cell
            
        }
        
    }
    
}
