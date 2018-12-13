//
//  NewListViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/13.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - NewListViewLayout

#if canImport(UIKit)

internal struct NewTableViewBridge {
    
    internal var numberOfSections: (UITableView) -> Int = { _ in 1 }
    
    internal var numberOfRows: (UITableView, _ section: Int) -> Int = { _, _ in 0 }
    
    internal var cellForRow: (UITableView, IndexPath) -> UITableViewCell = { _, _ in UITableViewCell() }
    
}

internal final class TableViewController: UITableViewController {
    
    internal final var bridge = NewTableViewBridge()
    
    internal final override func numberOfSections(in tableView: UITableView) -> Int { return bridge.numberOfSections(tableView) }
    
    internal final override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {
        
        return bridge.numberOfRows(
            tableView,
            section
        )
            
    }
    
    internal final override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {
        
        return bridge.cellForRow(
            tableView,
            indexPath
        )
            
    }
    
}

internal final class ListView: UIView, NewCollectionView {
    
    private final class Cell: UITableViewCell, ReusableCell { }
    
    private final lazy var tableViewController: TableViewController = {
        
        let tableViewController = TableViewController()
        
        tableViewController.tableView.backgroundColor = nil
        
        tableViewController.tableView.separatorStyle = .none
        
        tableViewController.tableView.registerCell(Cell.self)
        
        tableViewController.bridge.numberOfSections = { [weak self] _ in self?.dataSource?.sections.count ?? 0 }
        
        tableViewController.bridge.numberOfRows = { [weak self] _, section in self?.dataSource?.sections[section].count ?? 0 }
        
        tableViewController.bridge.cellForRow = { [weak self] tableView, indexPath in
            
            guard let dataSource = self?.dataSource else { return Cell() }
            
            let section = dataSource.sections[indexPath.section]
            
            let row = section[indexPath.row]
            
            let cell = tableView.dequeueCell(
                Cell.self,
                for: indexPath
            )
            
            cell.backgroundColor = nil
            
            cell.selectionStyle = .none
            
            switch row.viewRepresentation {
                
            case let .view(view): cell.contentView.wrapSubview(view)
                
            case let .viewController(cellViewController):
                
                if cellViewController.parent === tableViewController {
                    
                    if cellViewController.view.superview !== cell.contentView {
                        
                        cellViewController.view.removeFromSuperview()
                        
                        cell.contentView.wrapSubview(cellViewController.view)
                        
                    }
                    
                }
                else {
                    
                    if cellViewController.parent != nil {
                    
                        cellViewController.willMove(toParent: nil)
                        
                        cellViewController.view.removeFromSuperview()
                        
                        cellViewController.removeFromParent()
                        
                    }
                    
                    tableViewController.addChild(cellViewController)
                    
                    cell.contentView.wrapSubview(cellViewController.view)
                    
                    cellViewController.didMove(toParent: tableViewController)
                    
                }
                
            }
            
            return cell
            
        }
        
        tableViewController.loadViewIfNeeded()
        
        return tableViewController
        
    }()
    
    internal final weak var dataSource: CollectionViewDataSource?
    
    internal override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.load()
        
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.load()
        
    }
    
    private final func load() { wrapSubview(tableViewController.view) }
    
    public final func reloadData() { tableViewController.tableView.reloadData() }
    
}

public final class NewListViewLayout: NewCollectionViewLayout {
    
    private final let listView = ListView()
    
    public final var collectionView: View & NewCollectionView { return listView }
    
    public init() { }
    
}

#endif
