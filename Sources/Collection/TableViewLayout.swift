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
    
    private final let bridge = TableViewBridge()
    
    private final var tableView = TableView()
    
    public final var collectionView: View { return tableView }
    
    public init() {
        
        tableView.separatorStyle = .none
        
        tableView.register(Cell.self)
        
        tableView.dataSource = bridge
        
        tableView.prefetchDataSource = bridge
        
    }
    
    public func invalidate() { tableView.reloadData() }
    
    public final func setNumberOfSections(
        _ provider: @escaping (_ collectionView: View) -> Int
    ) {
        
        bridge.setNumberOfSections { [weak self] _ in
            
            if let self = self { return provider(self.collectionView) }
            
            return 0
            
        }
        
    }
    
    public final func setNumberOfItems(
        _ provider: @escaping (
            _ collectionView: View,
            _ section: Int
        )
        -> Int
    ) {
        
        bridge.setNumberOfRows { [weak self] _, section in
            
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
        _ provider: @escaping (
            _ collectionView: View,
            _ indexPath: IndexPath
        )
        -> View
    ) {
        
        bridge.setCellForRow { [weak self] tableView, indexPath in
            
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
        _ provider: @escaping (View, [IndexPath]) -> Void
    ) {
        
        bridge.setPrefetchingForRows { _, indexPaths in
         
            provider(
                self.collectionView,
                indexPaths
            )
            
        }
        
    }
    
}
