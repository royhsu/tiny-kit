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
    
    private final let flowLayout = UICollectionViewFlowLayout()
    
    private final let _collectionView: CollectionView
    
    public final var collectionView: View { return _collectionView }
    
    public init() {
        
        self._collectionView = CollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        
        self.prepare()
        
    }
    
    fileprivate final func prepare() {
        
        _collectionView.bridge = bridge
        
        _collectionView.registerCell(Cell.self)
    
        flowLayout.minimumInteritemSpacing = 0.0
        
        flowLayout.minimumLineSpacing = 0.0
        
        flowLayout.scrollDirection = .horizontal
        
        flowLayout.headerReferenceSize = .zero
        
        flowLayout.footerReferenceSize = .zero
        
        flowLayout.sectionInset = .zero
        
        bridge.setSizeForItem { [weak self] _, _, indexPath in
            
            guard
                let self = self
            else { return .zero }
            
            let layoutFrame = self._collectionView.layoutFrame
            
            #warning("Use magic width 100.0 for testing.")
            
            return CGSize(
                width: 100.0,
                height: layoutFrame.height
            )
            
        }
    
    }
    
    public final func invalidate() {
        
        flowLayout.invalidateLayout()
        
        #warning("Not sure if needs to manually call reloadData after invalidated layout.")
        _collectionView.reloadData()
        
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

// MARK: - Safe Area Rect

import UIKit

public extension UICollectionView {
    
    // swiftlint:disable identifier_name
    public final var layoutFrame: CGRect {
        
        let x: CGFloat

        let y: CGFloat
        
        let width: CGFloat
        
        let height: CGFloat
        
        if #available(iOS 11.0, *) {
            
            let layoutFrame = safeAreaLayoutGuide.layoutFrame
            
            x = layoutFrame.minX
            
            y = layoutFrame.minY
            
            width = layoutFrame.width
            
            height = layoutFrame.height
            
        }
        else {
            
            x = contentInset.left
            
            y = contentInset.top
            
            let expectedWidth = bounds.width
                - x
                - contentInset.right
            
            let expectedHeight = bounds.height
                - y
                - contentInset.bottom
            
            width = max(
                0.0,
                expectedWidth
            )
            
            height = max(
                0.0,
                expectedHeight
            )
            
        }
        
        return CGRect(
            x: x,
            y: y,
            width: width,
            height: height
        )
        
    }
    // swiftlint:enable identifier_name
    
}
