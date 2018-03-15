//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

/// NOTE: The maximum size of an item is limited to the size of the collection.
public final class UICollectionComponent: Component {
    
    public final var itemComponents: ComponentGroup {
        
        get { return bridge.componentGroup }
        
        set { bridge.componentGroup = newValue }
        
    }
    
    public final let collectionView: UICollectionView
    
    public final let collectionLayout: UICollectionViewFlowLayout
    
    private final let bridge: UICollectionViewCollectionComponentBridge
    
    public final var scrollDirection: UICollectionViewScrollDirection {
        
        get { return collectionLayout.scrollDirection }
        
        set { collectionLayout.scrollDirection = newValue }
        
    }
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.contentMode = contentMode
        
        let frame: CGRect
        
        switch contentMode {
            
        case let .size(width, height):
            
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
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView = collectionView
        
        self.bridge = UICollectionViewCollectionComponentBridge(collectionView: collectionView)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode
    
    public final func render() {
        
        collectionView.reloadData()
        
        /// Reference: https://stackoverflow.com/questions/22861804/uicollectionview-cellforitematindexpath-is-nil
        collectionView.layoutIfNeeded()
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(width, height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic: size = collectionLayout.collectionViewContentSize
            
        }
        
        collectionView.frame.size = size
        
    }
    
    // MARK: ViewRenderable

    public final var view: View { return collectionView }
    
    public final var preferredContentSize: CGSize { return collectionView.bounds.size }
    
}
