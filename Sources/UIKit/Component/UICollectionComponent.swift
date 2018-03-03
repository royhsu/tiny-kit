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
    
    private final let collectionViewLayout: UICollectionViewFlowLayout
    
    private final let bridge: UICollectionViewUICollectionComponentBridge
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.contentMode = contentMode
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        self.collectionViewLayout = collectionViewLayout
        
        let collectionView = UICollectionView(
            frame: UIScreen.main.bounds,
            collectionViewLayout: collectionViewLayout
        )
        
        self.collectionView = collectionView
        
        let bridge = UICollectionViewUICollectionComponentBridge(collectionView: collectionView)
        
        self.bridge = bridge
        
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
    
    public final var preferredContentSize: CGSize { return collectionViewLayout.collectionViewContentSize }
    
}
