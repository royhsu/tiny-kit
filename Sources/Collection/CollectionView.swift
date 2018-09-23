//
//  CollectionView.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CollectionView

#if canImport(UIKit)

import UIKit

public final class CollectionView: UICollectionView {
    
    public final var bridge: CollectionViewBridge? {
        
        didSet {
            
            dataSource = bridge
            
            prefetchDataSource = bridge
            
        }
        
    }
    
}

#else

public final class CollectionView: View {
    
    public final var bridge: CollectionViewBridge?
    
    public final func registerCell<Cell>(_ cellType: Cell.Type)
    where
        Cell: CollectionViewCell,
        Cell: ReusableCell { fatalError("Not implemented.") }
    
    public final func registerCell<Cell>(
        _ cellType: Cell.Type,
        bundle: Bundle?
    )
    where
        Cell: CollectionViewCell,
        Cell: ReusableCell,
        Cell: NibCell { fatalError("Not implemented.") }
    
    public final func reloadData() { fatalError("Not implemented.") }
    
}

#endif
