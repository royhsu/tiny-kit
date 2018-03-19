//
//  UINewListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponent

public final class UINewListComponent: Component {
    
    internal final let tableView: UITableView
    
    private final let bridge: UITableViewBridge
    
    public typealias ComponentForItemHandler = (IndexPath) -> Component?
    
    private final var componentForItemHandler: ComponentForItemHandler?
    
    private final var itemComponents: [Component]
    
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
        
        self.itemComponents = []
        
        bridge.configureCellHandler = { [unowned self] cell, indexPath in
            
            guard
                let component = self.componentForItemHandler?(indexPath)
            else { return }
            
            component.render()
            
            cell.contentView.render(with: component)
            
        }
        
        bridge.heightForRowHandler = { [unowned self] indexPath in
            
            guard
                let component = self.componentForItem(at: indexPath)
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
        
        itemComponents = []
        
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
    
    public typealias NumberOfSectionsHandler = UITableViewBridge.NumberOfSectionsHandler
    
    @discardableResult
    public final func setNumberOfSections(_ handler: NumberOfSectionsHandler?) -> UINewListComponent {
        
        bridge.numberOfSectionsHandler = handler
        
        return self
        
    }
    
    public final func numberOfSections() -> Int { return tableView.numberOfSections }
    
    public typealias NumberOfItemsHandler = UITableViewBridge.NumberOfRowsHandler
    
    @discardableResult
    public final func setNumberOfItems(_ handler: NumberOfItemsHandler?) -> UINewListComponent {
        
        bridge.numberOfRowsHandler = handler
        
        return self
        
    }
    
    public final func numberOfItems(inSection section: Int) -> Int { return tableView.numberOfRows(inSection: section) }
    
    @discardableResult
    public final func setComponentForItem(_ handler: ComponentForItemHandler?) -> UINewListComponent {
        
        componentForItemHandler = { indexPath in
            
            guard
                let component = handler?(indexPath)
            else { return nil }
            
            // Prevent the presenting child components get deallocated.
            self.itemComponents.append(component)
            
            return component
            
        }
        
        return self
        
    }
    
    public final func componentForItem(at indexPath: IndexPath) -> Component? { return componentForItemHandler?(indexPath) }
    
    // TODO: maybe it's better to make cell components detect their touching events.
    public typealias DidSelectItemHandler = (IndexPath) -> Void
    
    @discardableResult
    public final func setDidSelectItem(_ handler: DidSelectItemHandler?) -> UINewListComponent {
        
        bridge.didSelectRowHandler = handler
        
        return self
        
    }
    
}
