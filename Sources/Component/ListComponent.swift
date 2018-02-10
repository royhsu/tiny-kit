//
//  ListComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 28/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListComponent

import TinyCore

public final class ListComponent: Component {

    public final var headerComponent: Component? {

        didSet {

            guard
                let headerComponent = headerComponent
            else {

                tableView.tableHeaderView = nil

                return

            }

            headerComponent.view.frame = CGRect(
                origin: .zero,
                size: headerComponent.preferredContentSize
            )

            tableView.tableHeaderView = headerComponent.view

        }

    }

    public final var itemComponents = AnyCollection<Component>(
        []
    )

    private final let cellIdentifier = String(
        describing: UITableViewCell.self
    )

    internal final let tableView = UITableView(frame: UIScreen.main.bounds)

    private final let tableViewBridge: UITableViewBridge

    public init(contentMode: ComponentContentMode = .automatic) {

        self.contentMode = contentMode

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

    public final var preferredContentSize: CGSize { return tableView.bounds.size }

    // MAKR: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        tableViewBridge.components = itemComponents

        tableView.reloadData()

        tableView.layoutIfNeeded()

        let size: CGSize

        switch contentMode {

        case .size(let width, let height):

            size = CGSize(
                width: width,
                height: height
            )

        case .automatic:

            size = tableView.contentSize

        }

        var frame = tableView.frame

        frame.size = size

        tableView.frame = frame

    }

}
