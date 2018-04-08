//
//  UIListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIListComponent

public final class UIListComponent: ListComponent {

    internal final let tableView: UITableView

    fileprivate final let bridge: UITableViewBridge

    // Using this hack to trigger auto-resizing of the table view while it contains the nested auto-resizing child components. For example, the child component is also a list component.
    fileprivate final let tableViewHeightConstraint: NSLayoutConstraint

    public init(contentMode: ComponentContentMode = .automatic) {

        self.contentMode = contentMode

        let frame: CGRect

        switch contentMode {

        case let .size(size):

            frame = CGRect(
                origin: .zero,
                size: size
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

        self.tableViewHeightConstraint = tableView.heightAnchor.constraint(
            equalToConstant: tableView.bounds.height
        )

        NSLayoutConstraint.activate(
            [ tableViewHeightConstraint ]
        )

        self.numberOfSections = 0

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {

        bridge.configureCellHandler = { [unowned self] cell, indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return }

            cell.contentView.render(with: component)

            component.render()

        }

        bridge.heightForRowProvider = { [unowned self] indexPath in

            guard
                let component = self.itemComponentProvider?(indexPath)
            else { return  0.0 }

            switch component.contentMode {

            case let .size(size): return size.height

            case .automatic: return UITableViewAutomaticDimension

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

    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) { bridge.numberOfRowsProvider = provider }

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

        }

        tableView.frame.size = size

        tableViewHeightConstraint.constant = size.height

    }

    // MARK: ViewRenderable

    public final var view: View { return tableView }

    public final var preferredContentSize: CGSize { return tableView.bounds.size }

}
