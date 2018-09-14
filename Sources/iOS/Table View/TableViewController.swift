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

public typealias View = UIView

public protocol Updatable {
    
    func updateValue(_ value: Any?)
    
}

// MARK: - TemplateElement

public protocol TemplateElement {
    
    func makeView() -> View
    
}

public protocol Template {
    
    var elements: AnyCollection<TemplateElement> { get }
    
}

// TODO: a way to register multiple templates for the same view, and configure by json.
// always have a Default.self at the bottom.
//
// JSON config
//{
//    "template": "BLabel"
//}
//
// In code side.
//templates.register(
//  [
//    ALabel.self,
//    BLabel.self,
//    CLabel.self,
//    Default.self
//  ]
//)

open class TableViewController<Value>: UIViewController where Value: Equatable {

    private final class Cell: UITableViewCell, ReusableCell { }
    
    private final let tableView = UITableView()
    
    public final var template: Template? {
        
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
        
        dataSourceController.setNumberOfRows { [weak self] _, _ in self?.template?.elements.count ?? 0 }
        
        dataSourceController.setCellForRow { [weak self] _, indexPath in
            
            let elementIndex = AnyIndex(indexPath.row)
            
            guard
                let self = self,
                let element = self.template?.elements[elementIndex]
            else { return UITableViewCell() }
            
            let cell = self.tableView.dequeueReusableCell(
                Cell.self,
                for: indexPath
            )
            
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            let view = element.makeView()
            
            cell.contentView.wrapSubview(view)
            
            let value = self.storage?[indexPath.section]
            
            let updatable = view as? Updatable
            
            updatable?.updateValue(value)
            
            return cell
            
        }
        
    }
    
}

