//
//  LegacyListViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LegacyListViewLayout

import TinyCore

public final class LegacyListViewLayout: LegacyCollectionViewLayout {

    private final class Cell: TableViewCell, Reusable { }

    private final let bridge = LegacyTableViewBridge()

    public final var _viewController: ViewController? { return bridge }

    public final unowned let collectionView: LegacyCollectionView

    public init(collectionView: LegacyCollectionView) {

        self.collectionView = collectionView

        self.prepare()

    }

    fileprivate final func prepare() {

        bridge.tableView.backgroundColor = nil

        bridge.tableView.separatorStyle = .none

        bridge.tableView.registerCell(Cell.self)

        bridge.setNumberOfSections { _ in self.collectionView.sections.count }

        bridge.setNumberOfRows { _, section in

            let section = self.collectionView.sections.section(at: section)

            return section.count

        }

        bridge.setCellForRow { tableView, indexPath in

            let section = self.collectionView.sections.section(at: indexPath.section)

            let view = section.view(at: indexPath.row)

            let cell = tableView.dequeueCell(
                Cell.self,
                for: indexPath
            )

            cell.backgroundColor = nil

            cell.selectionStyle = .none

            cell.contentView.subviews.forEach { $0.removeFromSuperview() }

            cell.contentView.wrapSubview(view)

            return cell

        }

        bridge.tableView.alwaysBounceVertical = collectionView.alwaysBounceVertical

        collectionView.alwaysBounceVerticalDidChange = { [weak self] alwaysBounceVertical in

            self?.bridge.tableView.alwaysBounceVertical = alwaysBounceVertical

        }

    }

    public final func invalidate() { bridge.tableView.reloadData() }

}
