//
//  UITableViewListComponentBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewListComponentBridge

internal final class UITableViewListComponentBridge: NSObject {

    private final let cellIdentifier = String(
        describing: UITableViewCell.self
    )

    internal final let tableView: UITableView

    internal final var itemComponents: ListItemComponents?

    internal init(tableView: UITableView) {

        self.tableView = tableView

        super.init()

        setUpTableView(tableView)

    }

    // MARK: Set Up

    fileprivate final func setUpTableView(_ tableView: UITableView) {

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )

        tableView.separatorStyle = .none

        tableView.dataSource = self

        tableView.delegate = self

    }

}

// MARK: - UITableViewDataSource

extension UITableViewListComponentBridge: UITableViewDataSource {

    internal final func numberOfSections(in tableView: UITableView) -> Int {

        return itemComponents?.numberOfSections() ?? 0

    }

    internal final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {

        return itemComponents?.numberOfItemsAtSection(section) ?? 0

    }

    internal final func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        )

        cell.selectionStyle = .none

        cell.backgroundColor = .clear

        if let component = itemComponents?.componentForItem(at: indexPath) {

            component.render()

            cell.contentView.render(with: component)

        }

        return cell

    }

}

// MARK: - UITableViewDelegate

extension UITableViewListComponentBridge: UITableViewDelegate {

    internal final func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat {

        guard
            let component = itemComponents?.componentForItem(at: indexPath)
        else { return 0.0 }

        switch component.contentMode {

        case .size(_, let height): return height

        case .automatic: return UITableViewAutomaticDimension

        }

    }

}
