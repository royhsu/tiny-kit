//
//  TableViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TableViewLayout

public final class TableViewLayout: PrefetchableCollectViewLayout {
    
    private final class Cell: TableViewCell, ReusableCell { }
    
    private final let dataSource = UITableViewDataSourceController()
    
    private final var tableView = TableView()
    
    public final var collectionView: View { return tableView }
    
    public init() {
        
        tableView.separatorStyle = .none
        
        tableView.register(Cell.self)
        
        tableView.dataSource = dataSource
        
        #warning("TODO: consider to drop the old iOS versions.")
        if #available(iOS 10.0, *) {
            
            tableView.prefetchDataSource = dataSource
            
        }
        
    }
    
    public func invalidateLayout() { tableView.reloadData() }
    
    public final func setNumberOfSections(
        provider: @escaping (View) -> Int
    ) {
        
        dataSource.setNumberOfSections { [weak self] _ in
            
            if let self = self { return provider(self.collectionView) }
            
            return 0
            
        }
        
    }
    
    public final func setNumberOfItems(
        provider: @escaping (View, _ section: Int) -> Int
    ) {
        
        dataSource.setNumberOfRows { [weak self] _, section in
            
            if let self = self {
            
                return provider(
                    self.collectionView,
                    section
                )
                
            }
            
            return 0
            
        }
        
    }
    
    public final func setViewForItem(
        provider: @escaping (View, IndexPath) -> View
    ) {
        
        dataSource.setCellForRow { [weak self] tableView, indexPath in
            
            let cell = tableView.dequeueReusableCell(
                Cell.self,
                for: indexPath
            )
            
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
    
    public func setPrefetchingForItems(
        provider: @escaping (View, [IndexPath]) -> Void
    ) {
        
        dataSource.setPrefetchingForRows { _, indexPaths in
         
            provider(
                self.collectionView,
                indexPaths
            )
            
        }
        
    }
    
}
