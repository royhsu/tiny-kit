//
//  UIListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponent

public final class UIListComponent: Component {
    
    internal final let tableView: UITableView
    
    private final let bridge: UITableViewBridge
    
    public private(set) var headerComponent: Component?
    
    public private(set) var footerComponent: Component?
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
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
            frame = UIScreen.main.bounds
            
        }
        
        let tableView = UITableView(frame: frame)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView = tableView
        
        self.bridge = UITableViewBridge(tableView: tableView)
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        bridge.configureCellHandler = { [unowned self] cell, indexPath in
            
            guard
                let component = self.componentForItemHandler?(indexPath)
                else { return }
            
            component.render()
            
            cell.contentView.render(with: component)
            
        }
        
        bridge.heightForRowHandler = { [unowned self] indexPath in
            
            guard
                let component = self.componentForItemHandler?(indexPath)
            else { return 0.0 }
            
            switch component.contentMode {
                
            case let .size(_, height): return height
                
            case .automatic: return UITableViewAutomaticDimension
                
            }
            
        }
        
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
    
    // MARK: Action
    
    public typealias ComponentForItemHandler = (IndexPath) -> Component?
    
    private final var componentForItemHandler: ComponentForItemHandler?
    
}

public extension UIListComponent {
    
    @discardableResult
    public func setHeaderComponent(_ component: Component?) -> UIListComponent {
        
        headerComponent = component
        
        return self
        
    }
    
    @discardableResult
    public func setFooterComponent(_ component: Component?) -> UIListComponent {
        
        footerComponent = component
        
        return self
        
    }
    
    public typealias NumberOfSectionsHandler = UITableViewBridge.NumberOfSectionsHandler
    
    @discardableResult
    public final func setNumberOfSections(_ handler: NumberOfSectionsHandler?) -> UIListComponent {
        
        bridge.numberOfSectionsHandler = handler
        
        return self
        
    }
    
    public final var numberOfSections: Int { return tableView.numberOfSections }
    
    public typealias NumberOfItemsHandler = UITableViewBridge.NumberOfRowsHandler
    
    @discardableResult
    public final func setNumberOfItems(_ handler: NumberOfItemsHandler?) -> UIListComponent {
        
        bridge.numberOfRowsHandler = handler
        
        return self
        
    }
    
    public final func numberOfItems(inSection section: Int) -> Int { return tableView.numberOfRows(inSection: section) }
    
    @discardableResult
    public final func setComponentForItem(_ handler: ComponentForItemHandler?) -> UIListComponent {
        
        componentForItemHandler = handler
        
        return self
        
    }
    
    // TODO: maybe it's better to make cell components detect their touching events.
    public typealias DidSelectItemHandler = (IndexPath) -> Void
    
    @discardableResult
    public final func setDidSelectItem(_ handler: DidSelectItemHandler?) -> UIListComponent {
        
        bridge.didSelectRowHandler = handler
        
        return self
        
    }
    
}
