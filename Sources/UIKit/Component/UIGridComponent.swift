//
//  UIGridComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGridComponent

public final class UIGridComponent: CollectionComponent {
    
    /// The base component.
    private final let collectionComponent: UICollectionComponent
    
    private final let collectionViewFlowLayout: UICollectionViewFlowLayout
    
    public final var layout: UIGridLayout {
        
        didSet { collectionViewFlowLayout.scrollDirection = layout.scrollDirection }
        
    }
    
    public typealias MinimumItemSizeProvider = (UIGridLayout, IndexPath) -> CGSize
    
    /// The provider should return a proper width for columns in vertical scroll direction.
    /// and height for rows in horizontal scroll direction.
    /// If any of them are out of valid rect will be ignored.
    ///
    /// If this provider is nil, the component will calculate the column-based width and row-based height automatically to fit its safe area rect.
    public final var minimumItemSizeProvider: MinimumItemSizeProvider?
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        layout: UIGridLayout
    ) {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = 0.0
        
        flowLayout.minimumLineSpacing = 0.0
        
        flowLayout.headerReferenceSize = .zero
        
        flowLayout.footerReferenceSize = .zero
        
        flowLayout.sectionInset = .zero
        
        flowLayout.scrollDirection = layout.scrollDirection
        
        self.collectionViewFlowLayout = flowLayout
        
        self.collectionComponent = UICollectionComponent(
            contentMode: contentMode,
            layout: flowLayout
        )
        
        self.layout = layout
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        collectionComponent.sizeForItemProvider = { [unowned self] _, indexPath in
            
            let layout = self.layout
            
            let minimumItemSize = self.minimumItemSizeProvider?(
                layout,
                indexPath
            )
            
            let collectionViewFlowLayout = self.collectionViewFlowLayout
            
            let safeAreaRect = self.collectionView.safeAreaRect
            
            let gridWidth = safeAreaRect.width / CGFloat(layout.columns)
            
            let gridHeight = safeAreaRect.height / CGFloat(layout.rows)
            
            switch collectionViewFlowLayout.scrollDirection {
               
            case .vertical:
                
                return CGSize(
                    width: gridWidth,
                    height: minimumItemSize?.height ?? gridHeight
                )
                
            case .horizontal:
                
                return CGSize(
                    width: minimumItemSize?.width ?? gridWidth,
                    height: gridHeight
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
    
    public final var collectionView: UICollectionView { return collectionComponent.collectionView }
    
}
