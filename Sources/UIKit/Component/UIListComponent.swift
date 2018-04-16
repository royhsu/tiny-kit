//
//  UIListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponent

public final class UIListComponent: ListComponent {

    public final let tableView: UITableView

    fileprivate final let bridge: UITableViewBridge

    fileprivate final let tableViewWidthConstraint: NSLayoutConstraint
    
    fileprivate final let tableViewHeightConstraint: NSLayoutConstraint

    public init(contentMode: ComponentContentMode = .automatic) {

        self.contentMode = contentMode

        self.tableView = UITableView(
            frame: .zero,
            style: .plain
        )

        self.bridge = UITableViewBridge(tableView: tableView)

        self.tableViewWidthConstraint = tableView.heightAnchor.constraint(equalToConstant: tableView.bounds.height)
        self.tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: tableView.bounds.height)
        
        self.numberOfSections = 0

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            // Removing this will show layout constraint errors for current implementation.
            size = UIScreen.main.bounds.size
            
        case let .automatic2(estimatedSize): size = estimatedSize
            
        }
        
        tableView.frame.size = size
        
        bridge.configureCellHandler = { [unowned self] cell, indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return }
            
            let height: CGFloat
            
            switch component.contentMode {
             
            case let .size(size): height = size.height
                
            case .automatic: height = 44.0
                
            case let .automatic2(estimatedSize): height = estimatedSize.height
                
            }
            
            component.contentMode = .automatic2(
                estimatedSize: CGSize(
                    width: self.tableView.frame.width,
                    height: height
                )
            )
            
            // Must render firstly to get the correct constraints from Auto Layout.
            // This helps table view to dynamically resize cells.
            component.render()
            
            cell.contentView.wrapSubview(component.view)
            
        }

        bridge.heightForRowProvider = { [unowned self] indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return 0.0 }
            
            switch component.contentMode {

            case let .size(size): return size.height

            case .automatic: return UITableViewAutomaticDimension
                
            case .automatic2: return UITableViewAutomaticDimension

            }

        }
        
        tableView.backgroundColor = .clear
        
        tableView.clipsToBounds = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        tableViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        NSLayoutConstraint.activate(
            [
                tableViewWidthConstraint,
                tableViewHeightConstraint
            ]
        )
        
    }

    // MARK: ListComponent

    public final var headerComponent: Component?

    public final var footerComponent: Component?

    // MARK: CollectionComponent

    public final var numberOfSections: Int {

        get { return bridge.numberOfSections }

        set { bridge.numberOfSections = newValue }

    }
    
    public final func numberOfItemComponents(inSection section: Int) -> Int { return bridge.numberOfRowsProvider(section) }

    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) { bridge.numberOfRowsProvider = provider }
    
    public final func itemComponent(at indexPath: IndexPath) -> Component {
        
        guard
            let provider = itemComponentProvider
        else { fatalError("Please make sure to set the provider with setItemComponent(provider:) firstly.") }
        
        return provider(indexPath)
        
    }

    private final var itemComponentProvider: ItemComponentProvider?

    public final func setItemComponent(provider: @escaping ItemComponentProvider) { itemComponentProvider = provider }

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

        case let .size(value): size = value

        case .automatic: size = tableView.contentSize
            
        case .automatic2: size = tableView.contentSize

        }

        tableView.frame.size = size
        
        tableViewWidthConstraint.constant = size.width

        tableViewHeightConstraint.constant = size.height

    }

    // MARK: ViewRenderable

    public final var view: View { return tableView }

    public final var preferredContentSize: CGSize { return tableView.bounds.size }

}
