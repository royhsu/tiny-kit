//
//  UITableViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITableViewBridge

public final class UITableViewBridge: NSObject {

    private final unowned let tableView: UITableView

    public init(tableView: UITableView) {

        self.numberOfSections = 0

        self.numberOfRowsProvider = { _ in 0 }

        self.heightForRowProvider = { _ in 0.0 }

        self.tableView = tableView

        super.init()

        setUpTableView(tableView)

    }

    // MARK: Set Up

    fileprivate final func setUpTableView(_ tableView: UITableView) {

        tableView.separatorStyle = .none

        tableView.dataSource = self

        tableView.delegate = self

    }

    public final var numberOfSections: Int

    public typealias NumberOfRowsProvider = (_ section: Int) -> Int

    public final var numberOfRowsProvider: NumberOfRowsProvider

    public typealias HeightForRowProvider = (IndexPath) -> CGFloat

    public final var heightForRowProvider: HeightForRowProvider

    public typealias ConfigureCellHandler = (UITableViewCell, IndexPath) -> Void

    public final var configureCellHandler: ConfigureCellHandler?

}

// MARK: - UITableViewDataSource

extension UITableViewBridge: UITableViewDataSource {

    public final func numberOfSections(in tableView: UITableView) -> Int {
        
        // TODO: find a better way to log debugging info.
        print(self, #function, "->", numberOfSections)
        
        return numberOfSections
        
    }

    public final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {
        
        let rows = numberOfRowsProvider(section)
        
        // TODO: find a better way to log debugging info.
        print(self, #function, section, "->", "rows:", rows)
        
        return rows
        
    }

    public final func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    )
    -> UITableViewCell {

        // NOTE: DONNOT use reusable cells because they contain the incorrect height information while dequeued.
        let cell = UITableViewCell(
            style: .default,
            reuseIdentifier: nil
        )
        
        cell.selectionStyle = .none

        cell.backgroundColor = .clear
        
        configureCellHandler?(
            cell,
            indexPath
        )
        
        // TODO: find a better way to log debugging info.
        print(self, #function, indexPath, "->", "cell:", cell)

        return cell

    }

}

// MARK: - UITableViewDelegate

extension UITableViewBridge: UITableViewDelegate {
    
    public final func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    )
    -> CGFloat {
        
        let height = heightForRowProvider(indexPath)
        
        // TODO: find a better way to log debugging info.
        print(self, #function, indexPath, "->", "height:", height)
        
        return height
        
    }

}
