//
//  ListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponent

public final class ListComponent: Component {
    
    public final var childComponents = AnyCollection<Component>(
        []
    )

    private final let cellIdentifier = String(
        describing: UITableViewCell.self
    )
    
    private final let tableViewBridge: UITableViewBridge
    
    private final let tableView = UITableView()
    
    public init() {
        
        self.tableViewBridge = UITableViewBridge(cellIdentifier: cellIdentifier)
        
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
    
    // MARK: ViewRenderable
    
    public final var view: View { return tableView }

    public final var preferredContentSize: CGSize { return tableView.contentSize }
    
}

// MARK: - ViewRender

import TinyCore

extension ListComponent: ViewRender {
    
    public final var renderables: AnyCollection<ViewRenderable> {
        
        let renderables = childComponents.map { $0 as ViewRenderable }
        
        return AnyCollection(renderables)
        
    }
    
    public final func render() -> Promise<Void> {
     
        return Promise(in: .main) { fulfill, _, _ in
        
            DispatchQueue.main.async {
                
                self.tableViewBridge.renderables = self.renderables
                
                self.tableView.reloadData()
                
                self.tableView.layoutIfNeeded()
                
                let result: Void = ()
                
                fulfill(result)
                
            }
                
        }
        
    }
    
}
