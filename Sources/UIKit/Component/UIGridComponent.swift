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
        
        didSet {
            
            collectionViewFlowLayout.minimumInteritemSpacing = layout.interitemSpacing
            
            collectionViewFlowLayout.minimumLineSpacing = layout.lineSpacing
            
            collectionViewFlowLayout.scrollDirection = layout.scrollDirection
            
        }
        
    }
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        layout: UIGridLayout
    ) {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = layout.interitemSpacing
        
        flowLayout.minimumLineSpacing = layout.lineSpacing
        
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
        
        collectionComponent.setSizeForItem { [unowned self] _, indexPath in
            
            let layout = self.layout
            
            let collectionViewFlowLayout = self.collectionViewFlowLayout
            
            let safeAreaRect = self.collectionView.safeAreaRect
            
            switch collectionViewFlowLayout.scrollDirection {
               
            case .vertical:
                
                var spacingOfInteritems = CGFloat(layout.columns - 1) * layout.interitemSpacing
                
                if spacingOfInteritems < 0.0 { spacingOfInteritems = 0.0 }
                
                var spacingOfLines = CGFloat(layout.rows - 1) * layout.lineSpacing
                
                if spacingOfLines < 0.0 { spacingOfLines = 0.0 }
                
                let gridSize = CGSize(
                    width: (safeAreaRect.width - spacingOfInteritems) / CGFloat(layout.columns),
                    height: (safeAreaRect.height - spacingOfLines) / CGFloat(layout.rows)
                )
                
                let minimumItemSize = self.minimumItemSizeProvider?(
                    layout,
                    gridSize,
                    indexPath
                )
                
                let minimumItemHeight = minimumItemSize?.height ?? gridSize.height
                
                let itemHeight = (minimumItemHeight < gridSize.height)
                    ? minimumItemHeight
                    : gridSize.height

                return CGSize(
                    width: gridSize.width,
                    height: itemHeight
                )
                
            case .horizontal:
                
                var spacingOfInteritems = CGFloat(layout.rows - 1) * layout.interitemSpacing
                
                if spacingOfInteritems < 0.0 { spacingOfInteritems = 0.0 }
                
                var spacingOfLines = CGFloat(layout.columns - 1) * layout.lineSpacing
                
                if spacingOfLines < 0.0 { spacingOfLines = 0.0 }
                
                let gridSize = CGSize(
                    width: (safeAreaRect.width - spacingOfLines) / CGFloat(layout.columns),
                    height: (safeAreaRect.height - spacingOfInteritems) / CGFloat(layout.rows)
                )
                
                let minimumItemSize = self.minimumItemSizeProvider?(
                    layout,
                    gridSize,
                    indexPath
                )
                
                let minimumItemWidth = minimumItemSize?.width ?? gridSize.width
                
                let itemWidth = (minimumItemWidth < gridSize.width)
                    ? minimumItemWidth
                    : gridSize.width
                
                return CGSize(
                    width: itemWidth,
                    height: gridSize.height
                )
                
            }
            
        }
        
    }
    
    // MARK: CollectionComponent
    
    public final var numberOfSections: Int {
        
        get { return collectionComponent.numberOfSections }
        
        set { collectionComponent.numberOfSections = newValue }
        
    }
    
    public final func numberOfItemComponents(inSection section: Int) -> Int { return collectionComponent.numberOfItemComponents(inSection: section) }
    
    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) { collectionComponent.setNumberOfItemComponents(provider: provider) }
    
    public final func itemComponent(at indexPath: IndexPath) -> Component { return collectionComponent.itemComponent(at: indexPath) }
    
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
    
    // MARK: Action
    
    // TODO: should find a better api name & variable names.
    public typealias MinimumItemSizeProvider = (UIGridLayout, _ gridSize: CGSize, IndexPath) -> CGSize
    
    /// The provider should return a proper width for columns in vertical scroll direction.
    /// and height for rows in horizontal scroll direction.
    /// If any of them are out of valid rect will be ignored.
    ///
    /// If this provider is nil, the component will calculate the column-based width and row-based height automatically to fit its safe area rect.
    private final var minimumItemSizeProvider: MinimumItemSizeProvider?
    
    public final func setMinimumItemSize(provider: MinimumItemSizeProvider?) { minimumItemSizeProvider = provider }
    
}

public extension UIGridComponent {
    
    public final var collectionView: UICollectionView { return collectionComponent.collectionView }
    
}
