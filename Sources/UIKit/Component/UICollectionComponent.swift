//
//  UICollectionComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICollectionComponent

// TODO: make collection component internal. it's not ready to be public.
public final class UICollectionComponent: Component {
    
    public final var itemComponents: ComponentGroup {
        
        get { return bridge.componentGroup }
        
        set { bridge.componentGroup = newValue }
        
    }
    
    internal final let collectionView: UICollectionView
    
    private final let collectionLayout: UICollectionViewFlowLayout
    
    private final let bridge: UICollectionViewCollectionComponentBridge
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        collectionLayout: UICollectionViewFlowLayout
    ) {
        
        self.contentMode = contentMode
        
        self.collectionLayout = collectionLayout
        
        let frame: CGRect
        
        switch contentMode {
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            frame = UIScreen.main.bounds
            
        case .size(let width, let height):
            
            frame = CGRect(
                x: 0.0,
                y: 0.0,
                width: width,
                height: height
            )
            
        }
        
        let collectionView = UICollectionView(
            frame: frame,
            collectionViewLayout: collectionLayout
        )
        
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
            
        case .size(let width, let height):
            
            size = CGSize(
                width: width,
                height: height
            )
            
        case .automatic:
            
            size = collectionLayout.collectionViewContentSize
            
        }
        
        collectionView.frame.size = size
        
        print(collectionLayout.collectionViewContentSize)
        
    }
    
    // MARK: ViewRenderable

    public final var view: View { return collectionView }
    
    public final var preferredContentSize: CGSize { return collectionView.bounds.size }
    
}
