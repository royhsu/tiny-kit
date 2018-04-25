//
//  UIListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponent

/// Grouping a collection of item components in a list.
///
/// The list component uses the width specified in the content mode to calculate the rect of each associated components including the item, header and footer components.
/// That means the list overrides their content mode to fit the width during the rendering.
///
/// Please make sure to give a non-zero size for the list to properly render its content.
public final class UIListComponent: ListComponent {

    public final let tableView: UITableView

    fileprivate final let bridge: UITableViewBridge

    fileprivate final let tableViewWidthConstraint: NSLayoutConstraint
    
    fileprivate final let tableViewHeightConstraint: NSLayoutConstraint
    
    // DO NOT get an item component from the map directly, please use itemComponent(at:) instead.
    internal final var itemComponentMap: [IndexPath: Component]

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
        
        self.itemComponentMap = [:]
    
        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {
        
        prepareLayout()
        
        tableView.backgroundColor = .clear
        
        tableView.clipsToBounds = false
            
        bridge.configureCellHandler = { [unowned self] cell, indexPath in
                    
            let component = self.itemComponent(at: indexPath)
            
            cell.contentView.frame.size = component.preferredContentSize
            
            cell.frame.size = cell.contentView.frame.size
            
            cell.contentView.wrapSubview(component.view)
            
        }

        bridge.heightForRowProvider = { [unowned self] indexPath in

            let component = self.itemComponent(at: indexPath)
            
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
    
    fileprivate final func prepareLayout() {
        
        tableViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        tableViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        tableView.frame.size = contentMode.initialSize
        
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

    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) {
        
        bridge.numberOfRowsProvider = { [unowned self] section in
            
            return provider(
                self,
                section
            )
            
        }
        
    }
    
    public final func itemComponent(at indexPath: IndexPath) -> Component {
        
        if let provider = itemComponentMap[indexPath] { return provider }
        else {
            
            guard
                let provider = itemComponentProvider
            else { fatalError("Please make sure to set the provider with setItemComponent(provider:) firstly.") }
        
            let itemComponent = provider(
                self,
                indexPath
            )
        
            itemComponentMap[indexPath] = itemComponent
            
            return itemComponent
            
        }
        
    }

    private final var itemComponentProvider: ItemComponentProvider?

    public final func setItemComponent(provider: @escaping ItemComponentProvider) { itemComponentProvider = provider }

    // MARK: Component

    public final var contentMode: ComponentContentMode
    
    public final func render() {
        
        itemComponentMap = [:]
        
        let tableViewConstraints = [
            tableViewWidthConstraint,
            tableViewHeightConstraint
        ]
        
        NSLayoutConstraint.deactivate(tableViewConstraints)
        
        tableView.estimatedRowHeight = 0.0
        
        switch contentMode {

        case let .size(size):
            
            tableView.frame.size = size
            
            renderHeaderComponent(size: size)
            
            renderFooterComponent(size: size)
            
            tableView.tableHeaderView = headerComponent?.view
            
            tableView.tableFooterView = footerComponent?.view
            
            tableView.reloadData()
            
        case let .automatic(estimatedSize):
            
            tableView.frame.size = estimatedSize
            
            renderHeaderComponent(size: estimatedSize)
            
            renderFooterComponent(size: estimatedSize)
            
            tableView.tableHeaderView = headerComponent?.view
            
            tableView.tableFooterView = footerComponent?.view
            
            tableView.reloadData()
            
            tableView.layoutIfNeeded()
            
            tableView.frame.size = tableView.contentSize
            
        }

        tableViewWidthConstraint.constant = tableView.frame.width
        
        tableViewHeightConstraint.constant = tableView.frame.height
        
        NSLayoutConstraint.activate(tableViewConstraints)
    
    }
    
    fileprivate final func renderHeaderComponent(size: CGSize) {
        
        guard
            let component = headerComponent
        else { return }
        
        let height: CGFloat
        
        switch component.contentMode {
            
        case let .size(size): height = size.height
            
        case let .automatic(estimatedSize): height = estimatedSize.height
            
        }
        
        component.contentMode = .automatic(
            estimatedSize: CGSize(
                width: size.width,
                height: height
            )
        )
        
        component.render()
        
    }
    
    fileprivate final func renderFooterComponent(size: CGSize) {
        
        guard
            let component = footerComponent
        else { return }
        
        let height: CGFloat
        
        switch component.contentMode {
            
        case let .size(size): height = size.height
            
        case let .automatic(estimatedSize): height = estimatedSize.height
            
        }
        
        component.contentMode = .automatic(
            estimatedSize: CGSize(
                width: size.width,
                height: height
            )
        )
        
        component.render()
        
    }

    // MARK: ViewRenderable

    public final var view: View { return tableView }

    public final var preferredContentSize: CGSize { return tableView.bounds.size }

}
