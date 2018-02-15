//
//  UITableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewBridge

internal final class UITableViewBridge: NSObject {

    internal final let cellIdentifier: String

    internal final var components = AnyCollection<Component>(
        []
    )

    internal init(cellIdentifier: String) { self.cellIdentifier = cellIdentifier }

}

// MARK: - UITableViewDataSource

extension UITableViewBridge: UITableViewDataSource {

    internal final func numberOfSections(in tableView: UITableView) -> Int { return Int(components.count) }

    internal final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int { return 1 }

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

        let index = AnyIndex(indexPath.section)

        let component = components[index]

        component.render()

        cell.contentView.render(with: component)

        return cell

    }

}

// MARK: - UITableViewDelegate

extension UITableViewBridge: UITableViewDelegate {

    internal final func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat {

        let index = AnyIndex(indexPath.section)

        let component = components[index]

        switch component.contentMode {

        case .size(_, let height): return height

        case .automatic: return UITableViewAutomaticDimension

        }

    }

}
