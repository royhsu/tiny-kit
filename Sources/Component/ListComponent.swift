//
//  ListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponent

public final class ListComponent: Component {
    
    public var parent: Node? = nil
    
    public var childs: AnyCollection<Node> {
        
        let nodes = childComponents.map { $0 as Node }
        
        return AnyCollection(nodes)
        
    }
    
    public func addChild(_ node: Node) {
        fatalError()
    }
    
    public func removeFromParent() {
        fatalError()
    }
    
    public final var childComponents = AnyCollection<Component>([])
    
//    public final func setChildComponents(_ components: [Component]) {
//
//
//
//    }
    
    private final let cellIdentifier = String(
        describing: UITableViewCell.self
    )
    
    private final let bridge: ListBridge
    
    public final let tableView = UITableView()
    
    public init() {
        
        self.bridge = ListBridge(cellIdentifier: cellIdentifier)
        
//        super.init()
        
        setUpTableView(tableView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpTableView(_ tableView: UITableView) {
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )
        
        tableView.separatorStyle = .none
        
        tableView.dataSource = bridge
        
        tableView.delegate = bridge
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return tableView }

    public final var preferredContentSize: CGSize { return tableView.contentSize }
    
}

// MARK: - ViewRender

import TinyCore

extension ListComponent: ViewRender {
    
    public final var renderables: AnyCollection<ViewRenderable> {
        
        let renderables = childComponents.flatMap { $0 as ViewRenderable }
        
        return AnyCollection(renderables)
        
    }
    
    public final func render() -> Promise<Void> {
     
        return Promise(in: .main) { fulfill, _, _ in
        
            DispatchQueue.main.async {
                
                self.bridge.renderables = self.renderables
                
                self.tableView.reloadData()
                
                self.tableView.layoutIfNeeded()
                
                let result: Void = ()
                
                fulfill(result)
                
            }
                
        }
        
    }
    
}
