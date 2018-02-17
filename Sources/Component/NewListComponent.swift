//
//  NewListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponentDataSource

public protocol ListComponentDataSource {
    
    func numberOfSections() -> Int
    
    func numberOfItemsAtSection(_ section: Int) -> Int
    
    func componentForItem(at indexPath: IndexPath) -> Component
    
}

// MARK: - NewListComponent

public final class NewListComponent: Component {
    
    public final var headerComponent: Component?
    
    public final var footerComponent: Component?
    
    public final var dataSource: ListComponentDataSource? {
        
        get { return tableViewBridge.dataSource }
        
        set { tableViewBridge.dataSource = newValue }
        
    }
    
    internal final let tableView = UITableView(frame: UIScreen.main.bounds)
    
    private final let cellIdentifier = String(
        describing: UITableViewCell.self
    )
    
    private final let tableViewBridge: NewUITableViewBridge
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.contentMode = contentMode
        
        self.tableViewBridge = NewUITableViewBridge(cellIdentifier: cellIdentifier)
        
        setUpTableView(tableView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )
        
        tableView.separatorStyle = .none
        
        tableView.dataSource = tableViewBridge
        
        tableView.delegate = tableViewBridge
        
    }
    
    // MAKR: Component
    
    public final var contentMode: ComponentContentMode
    
    public final func render() {
        
        headerComponent?.render()
        
        footerComponent?.render()
        
        tableView.tableHeaderView = headerComponent?.view
        
        tableView.tableFooterView = footerComponent?.view
        
        tableView.reloadData()
        
        tableView.layoutIfNeeded()
        
        let size: CGSize
        
        switch contentMode {
            
        case .size(let width, let height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic:
            
            size = tableView.contentSize
            
        }
        
        tableView.frame.size = size
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return tableView }
    
    public final var preferredContentSize: CGSize { return tableView.bounds.size }
    
}

extension AnyCollection: ListComponentDataSource {
    
    public func numberOfSections() -> Int {
        
        return lazy.flatMap { $0 as? Component }.count
        
    }
    
    public func numberOfItemsAtSection(_ section: Int) -> Int {
        
        return 1
        
    }
    
    public func componentForItem(at indexPath: IndexPath) -> Component {
        
        let index = AnyIndex(indexPath.section)
    
        return lazy[index] as! Component
        
    }
    
}
