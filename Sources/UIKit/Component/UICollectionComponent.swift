//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

/// NOTE: The maximum size of an item is limited to the size of the collection.
internal final class UICollectionComponent: Component {
    
    internal final var itemComponents: ComponentGroup {
        
        get { return bridge.componentGroup }
        
        set { bridge.componentGroup = newValue }
        
    }
    
    internal final let collectionView: UICollectionView
    
    private final let collectionLayout: UICollectionViewFlowLayout
    
    private final let bridge: UICollectionViewCollectionComponentBridge
    
    internal final var scrollDirection: UICollectionViewScrollDirection {
        
        get { return collectionLayout.scrollDirection }
        
        set { collectionLayout.scrollDirection = newValue }
        
    }
    
    internal init(contentMode: ComponentContentMode = .automatic) {
        
        self.contentMode = contentMode
        
        let frame: CGRect
        
        switch contentMode {
            
        case .size(let width, let height):
            
            frame = CGRect(
                x: 0.0,
                y: 0.0,
                width: width,
                height: height
            )
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            frame = UIScreen.main.bounds
            
        }
        
        let collectionLayout = UICollectionViewFlowLayout()
        
        collectionLayout.minimumInteritemSpacing = 0.0
        
        collectionLayout.minimumLineSpacing = 0.0
        
        collectionLayout.headerReferenceSize = .zero
        
        collectionLayout.footerReferenceSize = .zero
        
        collectionLayout.sectionInset = .zero
        
        self.collectionLayout = collectionLayout
        
        let collectionView = UICollectionView(
            frame: frame,
            collectionViewLayout: collectionLayout
        )
        
        self.collectionView = collectionView
        
        self.bridge = UICollectionViewCollectionComponentBridge(collectionView: collectionView)
        
    }
    
    // MARK: Component
    
    internal final var contentMode: ComponentContentMode
    
    internal final func render() {
        
        collectionView.reloadData()
        
        /// Reference: https://stackoverflow.com/questions/22861804/uicollectionview-cellforitematindexpath-is-nil
        collectionView.layoutIfNeeded()
        
        let size: CGSize
        
        switch contentMode {
            
        case .size(let width, let height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic:
            
            size = collectionLayout.collectionViewContentSize
            
        }
        
        collectionView.frame.size = size
        
    }
    
    // MARK: ViewRenderable

    internal final var view: View { return collectionView }
    
    internal final var preferredContentSize: CGSize { return collectionView.bounds.size }
    
}
