//
//  UITableViewListComponentBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 17/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewListComponentBridge

internal final class UITableViewListComponentBridge: NSObject {

    internal final var componentGroup: ComponentGroup = AnyCollection(
        [Component]()
    )
    
    internal unowned final let tableView: UITableView

    internal init(tableView: UITableView) {

        self.tableView = tableView

        super.init()

        setUpTableView(tableView)

    }

    // MARK: Set Up

    fileprivate final func setUpTableView(_ tableView: UITableView) {

        tableView.registerCell(UITableViewCell.self)

        tableView.separatorStyle = .none

        tableView.dataSource = self

        tableView.delegate = self

    }

}

// MARK: - UITableViewDataSource

extension UITableViewListComponentBridge: UITableViewDataSource {

    internal final func numberOfSections(in tableView: UITableView) -> Int { return componentGroup.numberOfSections() }

    internal final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int { return componentGroup.numberOfItems(inSection: section) }

    internal final func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(
                UITableViewCell.self,
                for: indexPath
            )
        else { fatalError("Cannot dequeue a cell from type UITableViewCell.") }

        cell.selectionStyle = .none

        cell.backgroundColor = .clear

        let component = componentGroup.componentForItem(at: indexPath)

        component.render()

        cell.contentView.render(with: component)

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

        let component = componentGroup.componentForItem(at: indexPath)

        switch component.contentMode {

        case .size(_, let height): return height
            
        case .automatic: return component.preferredContentSize.height

        }

    }

}
