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
    
    public typealias NumberOfSectionsHandler = () -> Int
    
    public final var numberOfSectionsHandler: NumberOfSectionsHandler?
    
    public typealias NumberOfRowsHandler = (_ section: Int) -> Int
    
    public final var numberOfRowsHandler: NumberOfRowsHandler?
    
    public typealias ConfigureCellHandler = (UITableViewCell, IndexPath) -> ()
    
    public final var configureCellHandler: ConfigureCellHandler?
    
    public typealias HeightForRowHandler = (IndexPath) -> CGFloat
    
    public final var heightForRowHandler: HeightForRowHandler?
    
    public typealias DidSelectRowHandler = (IndexPath) -> Void
    
    public final var didSelectRowHandler: DidSelectRowHandler?
    
}

// MARK: - UITableViewDataSource

extension UITableViewBridge: UITableViewDataSource {
    
    public final func numberOfSections(in tableView: UITableView) -> Int {
        
        let sections = numberOfSectionsHandler?()
        
        return sections ?? 0
        
    }
    
    public final func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    )
    -> Int {
        
        let rows = numberOfRowsHandler?(section)
        
        return rows ?? 0
        
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
        
        let height = heightForRowHandler?(indexPath)
        
        return height ?? 0.0
            
    }
    
}
