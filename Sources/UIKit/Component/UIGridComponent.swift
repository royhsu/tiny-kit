//
//  UIGridComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

public struct UIGridLayout {
    
    public var columns: Int
    
    public var rows: Int
    
    public init(
        columns: Int,
        rows: Int
    ) {
      
        self.columns = columns
        
        self.rows = rows
        
    }
    
}

// MARK: - UIGridComponent

public final class UIGridComponent: CollectionComponent {
    
    /// The base component.
    private final let collectionComponent: UICollectionComponent
    
    public final var layout: UIGridLayout
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        layout: UIGridLayout
    ) {
        
        self.collectionComponent = UICollectionComponent(contentMode: contentMode)
        
        self.layout = layout
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        collectionComponent.sizeForItemProvider = { [unowned self] _, indexPath in
            
            let collectionComponent = self.collectionComponent
            
            let collectionView = collectionComponent.collectionView
            
            var maxWidth = collectionView.bounds.width
                - collectionView.contentInset.left
                - collectionView.contentInset.right
                - collectionView.safeAreaInsets.left
                - collectionView.safeAreaInsets.right

            if maxWidth < 0.0 { maxWidth = 0.0 }

            var maxHeight = collectionView.bounds.height
                - collectionView.contentInset.top
                - collectionView.contentInset.bottom
                - collectionView.safeAreaInsets.top
                - collectionView.safeAreaInsets.bottom

            if maxHeight < 0.0 { maxHeight = 0.0 }
            
            switch collectionComponent.scrollDirection {
               
            case .vertical:
                
                let width = maxWidth / CGFloat(self.layout.columns)
                
                let height: CGFloat = 150.0
                
                return CGSize(
                    width: width,
                    height: height
                )
                
            case .horizontal:
                
                let width: CGFloat = 150.0
                
                let height = maxHeight / CGFloat(self.layout.rows)
                
                return CGSize(
                    width: width,
                    height: height
                )
                
            }
            
        }
        
    }
    
    // MARK: CollectionComponent
    
    public final var numberOfSections: Int {
        
        get { return collectionComponent.numberOfSections }
        
        set { collectionComponent.numberOfSections = newValue }
        
    }
    
    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) { collectionComponent.setNumberOfItemComponents(provider: provider) }
    
    public final func setItemComponent(provider: @escaping ItemComponentProvider) { collectionComponent.setItemComponent(provider: provider) }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return collectionComponent.contentMode }
        
        set { collectionComponent.contentMode = newValue }
        
    }
    
    public final func render() { collectionComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionComponent.view }
    
    public final var preferredContentSize: CGSize { return  collectionComponent.preferredContentSize }
    
}

public extension UIGridComponent {
    
    public final var scrollDirection: UICollectionViewScrollDirection {
        
        get { return collectionComponent.scrollDirection }
        
        set { collectionComponent.scrollDirection = newValue }
        
    }
    
}
