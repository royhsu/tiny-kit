//
//  ListView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListView

internal final class ListView: UIView, CollectionView {
    
    #if canImport(UIKit)
    
    private final class Cell: UITableViewCell, Reusable { }
    
    #endif
    
    private final lazy var listViewController: ListViewController = {
        
        let listViewController = ListViewController()
        
        listViewController.tableView.backgroundColor = nil
        
        listViewController.tableView.separatorStyle = .none
        
        listViewController.tableView.registerCell(Cell.self)
        
        listViewController.bridge.numberOfSections = { [weak self] _ in self?.dataSource?.sections.count ?? 0 }
        
        listViewController.bridge.numberOfRows = { [weak self] _, section in self?.dataSource?.sections[section].count ?? 0 }
        
        listViewController.bridge.cellForRow = { [weak self] tableView, indexPath in
            
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
                
                if cellViewController.parent === listViewController {
                    
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
                    
                    listViewController.addChild(cellViewController)
                    
                    cell.contentView.wrapSubview(cellViewController.view)
                    
                    cellViewController.didMove(toParent: listViewController)
                    
                }
                
            }
            
            return cell
            
        }
        
        listViewController.loadViewIfNeeded()
        
        return listViewController
        
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
    
    private final func load() { wrapSubview(listViewController.view) }
    
    public final func reloadData() { listViewController.tableView.reloadData() }
    
}
