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

#warning("TODO: missing test.")
public final class CarouselViewLayout: PrefetchableCollectViewLayout {
    
    private final class Cell: CollectionViewCell, ReusableCell { }
    
    private final let bridge = CollectionViewBridge()
    
    private final let flowLayout = UICollectionViewFlowLayout()
    
    private final let _collectionView: CollectionView
    
    public final var collectionView: View { return _collectionView }
    
    private typealias WidthForItem = (
        _ collectionView: View,
        _ layoutFrame: CGRect,
        _ indexPath: IndexPath
    )
    -> CGFloat
    
    private final var _widthForItem: WidthForItem?
    
    public final var interitemSpacing: CGFloat {
        
        get { return flowLayout.minimumLineSpacing }
        
        set { flowLayout.minimumLineSpacing = newValue }
        
    }
    
    public final var showsScrollIndicator: Bool {
        
        get { return _collectionView.showsHorizontalScrollIndicator }
        
        set { _collectionView.showsHorizontalScrollIndicator = newValue }
        
    }
    
    #warning("""
    The paging effect is not working what I want.
    Reson:
    1. https://stackoverflow.com/questions/42486960/uicollectionview-horizontal-paging-with-space-between-pages
    2. https://stackoverflow.com/questions/19067459/uiscrollview-paging-enabled-with-content-inset-is-working-strange
    """)
//    public final var isPagingEnabled: Bool {
//
//        get { return _collectionView.isPagingEnabled }
//
//        set { _collectionView.isPagingEnabled = newValue }
//
//    }
    
    @available(iOS 11.0, *)
    public final var directionalContentInsets: NSDirectionalEdgeInsets {
        
        get {
            
            let direction = View.userInterfaceLayoutDirection(for: collectionView.semanticContentAttribute)
            
            let insets = _collectionView.contentInset
            
            switch direction {
                
            case .leftToRight:
                
                return .init(
                    top: insets.top,
                    leading: insets.left,
                    bottom: insets.bottom,
                    trailing: insets.right
                )
             
            case .rightToLeft:
                
                return .init(
                    top: insets.top,
                    leading: insets.right,
                    bottom: insets.bottom,
                    trailing: insets.left
                )
                
            }
            
        }
        
        set(newInsets) {
            
            let direction = View.userInterfaceLayoutDirection(for: collectionView.semanticContentAttribute)
            
            switch direction {
                
            case .leftToRight:
                
                _collectionView.contentInset = .init(
                    top: newInsets.top,
                    left: newInsets.leading,
                    bottom: newInsets.bottom,
                    right: newInsets.trailing
                )
                
            case .rightToLeft:
                
                _collectionView.contentInset = .init(
                    top: newInsets.top,
                    left: newInsets.trailing,
                    bottom: newInsets.bottom,
                    right: newInsets.leading
                )
                
            }
            
        }
        
    }
    
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
                let self = self,
                let widthForItem = self._widthForItem
            else { return .zero }
            
            let layoutFrame = self._collectionView.layoutFrame
            
            let width = widthForItem(
                self.collectionView,
                layoutFrame,
                indexPath
            )
            
            return CGSize(
                width: width,
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
    
    #warning("Documentation: required. The default value is zero.")
    public final func setWidthForItem(
        _ provider: @escaping (
            _ collectionView: View,
            _ layoutFrame: CGRect,
            _ indexPath: IndexPath
        )
        -> CGFloat
    ) { _widthForItem = provider }
    
}

#else

#error("No carousel view layout for the current platform.")

#endif
