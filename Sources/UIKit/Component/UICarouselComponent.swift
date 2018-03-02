//
//  UICarouselComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICarouselComponent

public final class UICarouselComponent: Component {
    
    public final var itemComponents: ListItemComponents {
        
        get { return bridge.itemComponents }
        
        set { bridge.itemComponents = newValue }
        
    }
    
    internal final let collectionView: UICollectionView
    
    private final let collectionViewLayout: UICollectionViewFlowLayout
    
    private final let bridge: UICollectionViewUICarouselComponentBridge
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.contentMode = contentMode
        
//        open var minimumLineSpacing: CGFloat
//
//        open var minimumInteritemSpacing: CGFloat
//
//        open var itemSize: CGSize
//
//        @available(iOS 8.0, *)
//        open var estimatedItemSize: CGSize // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
//
//        open var scrollDirection: UICollectionViewScrollDirection // default is UICollectionViewScrollDirectionVertical
//
//        open var headerReferenceSize: CGSize
//
//        open var footerReferenceSize: CGSize
//
//        open var sectionInset: UIEdgeInsets
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        self.collectionViewLayout = collectionViewLayout
        
        let collectionView = UICollectionView(
            frame: UIScreen.main.bounds,
            collectionViewLayout: collectionViewLayout
        )
        
        self.collectionView = collectionView
        
        let bridge = UICollectionViewUICarouselComponentBridge(collectionView: collectionView)
        
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
