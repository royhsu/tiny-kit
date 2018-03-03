//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

public final class UICollectionComponent: Component {
    
    public final var itemComponents: ComponentGroup {
        
        get { return bridge.itemComponents }
        
        set { bridge.itemComponents = newValue }
        
    }
    
    internal final let collectionView: UICollectionView
    
    private final let collectionLayout: UICollectionViewLayout
    
    private final let bridge: UICollectionViewUICollectionComponentBridge
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        collectionLayout: UICollectionViewLayout
    ) {
        
        self.contentMode = contentMode
        
        self.collectionLayout = collectionLayout
        
        let collectionView = UICollectionView(
            frame: UIScreen.main.bounds, // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            collectionViewLayout: collectionLayout
        )
        
        self.collectionView = collectionView
        
        self.bridge = UICollectionViewUICollectionComponentBridge(collectionView: collectionView)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode
    
    public final func render() {
        
        collectionView.reloadData()
        
        /// Reference: https://stackoverflow.com/questions/22861804/uicollectionview-cellforitematindexpath-is-nil
        collectionView.layoutIfNeeded()
        
    }
    
    // MARK: ViewRenderable

    public final var view: View { return collectionView }
    
    public final var preferredContentSize: CGSize { return collectionLayout.collectionViewContentSize }
    
}
