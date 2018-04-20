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

    /// If providing a dedicated width of the estimatedSize with mode .automatic, the list will be able to use this width to calculate the height dynamically based on the content of each item component.
    /// Please make sure to call the function render() again if the content of any item components changed.
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

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
        
        tableViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        tableViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        tableView.backgroundColor = .clear
        
        tableView.clipsToBounds = false
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case let .automatic(estimatedSize): size = estimatedSize
            
        }
        
        tableView.frame.size = size
        
        tableView.estimatedRowHeight = 0.0
        
        bridge.configureCellHandler = { [unowned self] cell, indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return }
            
            cell.contentView.wrapSubview(component.view)
            
        }

        bridge.heightForRowProvider = { [unowned self] indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return 0.0 }
            
            switch component.contentMode {

            case let .size(size):
                
                component.contentMode = .size(
                    CGSize(
                        width: self.tableView.frame.width,
                        height: size.height
                    )
                )
                
                component.render()
                
                return size.height
                
            case let .automatic(estimatedSize):

                component.contentMode = .automatic(
                    estimatedSize: CGSize(
                        width: self.tableView.frame.width,
                        height: estimatedSize.height
                    )
                )
                
                component.render()
                
                return component.view.frame.height
                
            }

        }
        
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
        
        let tableViewConstraints = [
            tableViewWidthConstraint,
            tableViewHeightConstraint
        ]
        
        NSLayoutConstraint.deactivate(tableViewConstraints)

        switch contentMode {

        case let .size(size):
            
            tableView.frame.size = size
            
            tableView.reloadData()
            
        case let .automatic(estimatedSize):
            
            tableView.frame.size = estimatedSize
            
            tableView.reloadData()
            
            tableView.layoutIfNeeded()
            
            tableView.frame.size.height = tableView.contentSize.height
            
        }
        
        tableViewWidthConstraint.constant = tableView.frame.size.width

        tableViewHeightConstraint.constant = tableView.frame.size.height
        
        NSLayoutConstraint.activate(tableViewConstraints)
        
        headerComponent?.render()
        
        footerComponent?.render()
        
        tableView.tableHeaderView = headerComponent?.view
        
        tableView.tableFooterView = footerComponent?.view

    }

    // MARK: ViewRenderable

    public final var view: View { return tableView }

    public final var preferredContentSize: CGSize { return tableView.bounds.size }

}
