//
//  UINewListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponent

public final class UINewListComponent: ListComponent {
    
    internal final let tableView: UITableView
    
    fileprivate final let bridge: UITableViewBridge
    
    public private(set) var headerComponent: Component?
    
    public private(set) var footerComponent: Component?
    
    public private(set) var itemComponentGroup: ComponentGroup
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        headerComponent: Component? = nil,
        footerComponent: Component? = nil,
        itemComponentGroup: ComponentGroup
    ) {
        
        self.contentMode = contentMode
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(width, height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic:
            
            size = CGSize(
                width: 500.0,
                height: 500.0
            )
            
        }
        
        self.tableView = UITableView(
            frame: CGRect(
                origin: .zero,
                size: size
            ),
            style: .plain
        )
        
        self.bridge = UITableViewBridge(tableView: tableView)
        
        self.headerComponent = headerComponent
        
        self.footerComponent = footerComponent
        
        self.itemComponentGroup = itemComponentGroup
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {

        bridge.configureCellHandler = { [unowned self] cell, indexPath in
            
            guard
                let component = self.itemComponentGroup.element(at: indexPath)
            else { return }
            
            component.render()
            
            cell.contentView.render(with: component)
            
        }
        
        bridge.heightForRowHandler = { [unowned self] indexPath in
            
            guard
                let component = self.itemComponentGroup.element(at: indexPath)
            else { return 0.0 }
            
            switch component.contentMode {
                
            case let .size(_, height): return height
                
            case .automatic: return UITableViewAutomaticDimension
                
            }
            
        }
        
    }
    
    // MARK: ListComponent
    
    @discardableResult
    public func setHeader(component: Component?) -> UINewListComponent {
        
        headerComponent = component
        
        return self
        
    }
    
    @discardableResult
    public func setFooter(component: Component?) -> UINewListComponent {
        
        footerComponent = component
        
        return self
        
    }
    
    @discardableResult
    public func setItemComponentGroup(_ group: CollectionComponent.ComponentGroup) -> UINewListComponent {
        
        itemComponentGroup = group
        
        return self
        
    }
    
    // MARK: Component
    
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
            
        case let .size(width, height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic: size = tableView.contentSize
            
        }
        
        tableView.frame.size = size
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return tableView }
    
    public final var preferredContentSize: CGSize { return tableView.bounds.size }
    
}
