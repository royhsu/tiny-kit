//
//  UICollectionViewBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionViewBridge

import UIKit

public final class UICollectionViewBridge: NSObject {
    
    public typealias NumberOfSections = (_ collectionView: UICollectionView) -> Int
    
    public typealias NumberOfItems = (
        _ collectionView: UICollectionView,
        _ section: Int
    )
    -> Int
    
    public typealias CellForItem = (
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath
    )
    -> UICollectionViewCell
    
    public typealias PrefetchingForItems = (
        _ collectionView: UICollectionView,
        _ indexPaths: [IndexPath]
    )
    -> Void
    
    private final var _numberOfSections: NumberOfSections?
    
    private final var _numberOfItems: NumberOfItems?
    
    private final var _cellForItem: CellForItem?
    
    private final var _prefetchingForItems: PrefetchingForItems?
    
    public override init() { super.init() }
    
    public final func setNumberOfSections(_ provider: NumberOfSections?) { _numberOfSections = provider }
    
    public final func setNumberOfItems(_ provider: NumberOfItems?) { _numberOfItems = provider }
    
    public final func setCellForItem(_ provider: CellForItem?) { _cellForItem = provider }
    
    public final func setPrefetchingForItems(_ provider: PrefetchingForItems?) { _prefetchingForItems = provider }
    
}

// MARK: - UICollectionViewBridge

extension UICollectionViewBridge: UICollectionViewDataSource {
    
    public final func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        let sections = _numberOfSections?(collectionView)
        
        return sections ?? 1
        
    }
    
    public final func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    )
    -> Int {
        
        let items = _numberOfItems?(
            collectionView,
            section
        )
        
        return items ?? 0
        
    }
    
    public final func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    )
    -> UICollectionViewCell {
        
        guard
            let cell = _cellForItem?(
                collectionView,
                indexPath
            )
        else { fatalError("Cannot dequeue a cell from the given index path: \(indexPath)") }
        
        return cell
        
    }
    
}

// MARK: - UICollectionViewDataSourcePrefetching

extension UICollectionViewBridge: UICollectionViewDataSourcePrefetching {
    
    public final func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]
    ) {
    
        _prefetchingForItems?(
            collectionView,
            indexPaths
        )
        
    }
    
}
