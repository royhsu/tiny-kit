//
//  ListViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ListViewLayout

public final class ListViewLayout: ViewController, PrefetchableCollectViewLayout {

    private final class Cell: TableViewCell, ReusableCell { }

    private final let bridge = TableViewBridge()

    public final var collectionView: View { return bridge.tableView }

    public init() {
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.prepare()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.prepare()
        
    }
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChild(bridge)
        
        view.wrapSubview(bridge.view)
        
        bridge.didMove(toParent: self)
        
    }
    
    fileprivate final func prepare() {
        
        bridge.tableView.backgroundColor = nil
        
        bridge.tableView.separatorStyle = .none

        bridge.tableView.registerCell(Cell.self)

    }

    public final func invalidate() { bridge.tableView.reloadData() }

    public final var numberOfSections: Int { return bridge.tableView.numberOfSections }

    public final func setNumberOfSections(
        _ provider: @escaping (_ collectionView: View) -> Int
    ) {

        bridge.setNumberOfSections { [weak self] _ in

            guard
                let self = self
            else { return 0 }

            return provider(self.collectionView)

        }

    }

    public final func numberOfItems(atSection section: Int) -> Int { return bridge.tableView.numberOfRows(inSection: section) }

    public final func setNumberOfItems(
        _ provider: @escaping (
            _ collectionView: View,
            _ section: Int
        )
        -> Int
    ) {

        bridge.setNumberOfRows { [weak self] _, section in

            guard
                let self = self
            else { return 0 }

            return provider(
                self.collectionView,
                section
            )

        }

    }

    public final func viewForItem(at indexPath: IndexPath) -> View {

        guard
            let cell = bridge.tableView.cellForRow(at: indexPath)
        else { fatalError("Please make sure the cell is visible.") }

        guard
            let view = cell.contentView.subviews.first
        else { fatalError("The view must be the first view of the content view of a cell. ") }

        return view

    }

    public final func setViewForItem(
        _ provider: @escaping (
            _ collectionView: View,
            _ indexPath: IndexPath
        )
        -> View
    ) {

        bridge.setCellForRow { [weak self] tableView, indexPath in

            let cell = tableView.dequeueCell(
                Cell.self,
                for: indexPath
            )
            
            cell.backgroundColor = nil
            
            cell.selectionStyle = .none

            guard
                let self = self
            else { return cell }

            let view = provider(
                self.collectionView,
                indexPath
            )

            cell.contentView.subviews.forEach { $0.removeFromSuperview() }

            cell.contentView.wrapSubview(view)

            return cell

        }

    }

    public final func setPrefetchingForItems(
        _ provider: @escaping (
            _ collectionview: View,
            _ indexPaths: [IndexPath]
        )
        -> Void
    ) {

        bridge.setPrefetchingForRows { _, indexPaths in

            provider(
                self.collectionView,
                indexPaths
            )

        }

    }

}
