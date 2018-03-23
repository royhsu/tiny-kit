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
        
        let frame: CGRect
        
        switch contentMode {
            
        case let .size(width, height):
            
            frame = CGRect(
                x: 0.0,
                y: 0.0,
                width: width,
                height: height
            )
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            // Removing this will show layout constraint errors for current implementation.
            frame = UIScreen.main.bounds
            
        }
        
        self.tableView = UITableView(
            frame: frame,
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
        
        bridge.numberOfSectionsHandler = { [unowned self] in self.itemComponentGroup.numberOfSections }

        bridge.numberOfRowsHandler = { [unowned self] section in
            
            self.itemComponentGroup.numberOfElements(inSection: section)
            
        }
        
        bridge.configureCellHandler = { [unowned self] cell, indexPath in
            
            let component = self.itemComponentGroup.element(at: indexPath)
            
            component.render()
            
            cell.contentView.render(with: component)
            
        }
        
        bridge.heightForRowHandler = { [unowned self] indexPath in
            
            let component = self.itemComponentGroup.element(at: indexPath)
            
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

public extension UINewListComponent {
    
    public convenience init(
        contentMode: ComponentContentMode = .automatic,
        headerComponent: Component? = nil,
        footerComponent: Component? = nil,
        itemComponents: [Component] = []
    ) {
        
        self.init(
            contentMode: contentMode,
            headerComponent: headerComponent,
            footerComponent: footerComponent,
            itemComponentGroup: AnyIndexableGroup(itemComponents)
        )
        
    }
    
}
