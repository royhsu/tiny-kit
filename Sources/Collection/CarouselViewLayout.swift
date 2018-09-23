//
//  CarouselViewLayout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - CarouselViewLayout

#if canImport(UIKit)

import UIKit

public final class CarouselViewLayout: PrefetchableCollectViewLayout {
    
    private final class Cell: CollectionViewCell, ReusableCell { }
    
    private final let bridge = CollectionViewBridge()
    
    public final let _collectionView = CollectionView()
    
    public final var collectionView: View { return _collectionView }
    
    public init() {
        
        _collectionView.bridge = bridge
        
        _collectionView.registerCell(Cell.self)
        
    }
    
    public final func invalidate() {
        
        _collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
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
    
    public final func setNumberOfItems(
        _ provider: @escaping (
            _ collectionView: View,
            _ section: Int
        )
        -> Int
    ) {
        
        bridge.setNumberOfItems { [weak self] _, section in
            
            guard
                let self = self
            else { return 0 }
            
            return provider(
                self.collectionView,
                section
            )
            
        }
        
    }
    
    public final func setViewForItem(
        _ provider: @escaping (
            _ collectionView: View,
            _ indexPath: IndexPath
        )
        -> View
    ) {
        
        bridge.setCellForItem { [weak self] collectionView, indexPath in
            
            let cell = collectionView.dequeueCell(
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
    
    public final func setPrefetchingForItems(
        _ provider: @escaping (
            _ collectionView: View,
            _ indexPaths: [IndexPath]
        )
        -> Void
    ) {
        
        bridge.setPrefetchingForItems { _, indexPaths in
            
            provider(
                self.collectionView,
                indexPaths
            )
            
        }
        
    }
    
}

#else

#error("No carousel view layout for the current platform.")

#endif
