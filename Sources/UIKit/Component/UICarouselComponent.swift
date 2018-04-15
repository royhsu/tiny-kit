//
//  UICarouselComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

public struct UICarouselLayout {
    
    public var interitemSpacing: CGFloat
    
    public init(interitemSpacing: CGFloat = 0.0) { self.interitemSpacing = interitemSpacing }
    
}

// MARK: - UICarouselComponent

/// All items in a carousel component will be stretch out their height to fit the parent.
public final class UICarouselComponent: CollectionComponent {

    /// The base component.
    private final let gridComponent: UIGridComponent
    
    public final var layout: UICarouselLayout {
        
        didSet { gridComponent.layout.lineSpacing = layout.interitemSpacing }
        
    }

    public init(
        contentMode: ComponentContentMode = .automatic,
        layout: UICarouselLayout = UICarouselLayout()
    ) {
        
        self.gridComponent = UIGridComponent(
            contentMode: contentMode,
            layout: UIGridLayout(
                columns: 1,
                rows: 1,
                lineSpacing: layout.interitemSpacing,
                scrollDirection: .horizontal
            )
        )
        
        self.layout = layout
        
        self.prepare()

    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() { collectionView.showsVerticalScrollIndicator = false }

    // MARK: CollectionComponent
    
    public final var numberOfSections: Int {
        
        get { return gridComponent.numberOfSections }
        
        set { gridComponent.numberOfSections = newValue }
        
    }
    
    public final func numberOfItemComponents(inSection section: Int) -> Int { return gridComponent.numberOfItemComponents(inSection: section) }
    
    public final func setNumberOfItemComponents(provider: @escaping NumberOfItemComponentsProvider) { gridComponent.setNumberOfItemComponents(provider: provider) }
    
    public final func itemComponent(at indexPath: IndexPath) -> Component { return gridComponent.itemComponent(at: indexPath) }
    
    public final func setItemComponent(provider: @escaping ItemComponentProvider) { gridComponent.setItemComponent(provider: provider) }
    
    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return gridComponent.contentMode }

        set { gridComponent.contentMode = newValue }

    }

    public final func render() { gridComponent.render() }

    // MARK: ViewRenderable

    public final var view: View { return gridComponent.view }

    public final var preferredContentSize: CGSize { return gridComponent.preferredContentSize }
    
    // MARK: Action
    
    public typealias MinimumItemWidthProvider = (_ index: Int) -> CGFloat
    
    private final var minimumItemWidthProvider: MinimumItemWidthProvider? {
        
        didSet {
            
            if let provider = minimumItemWidthProvider {
                
                gridComponent.setMinimumItemSize { _, _, indexPath in
                    
                    let width = provider(indexPath.item)
                    
                    return CGSize(
                        width: width,
                        height: width
                    )
                    
                }
                
            }
            else { gridComponent.setMinimumItemSize(provider: nil) }
            
        }
        
    }
    
    public final func setMinimumItemWidth(provider: @escaping MinimumItemWidthProvider) { minimumItemWidthProvider = provider }

}

public extension UICarouselComponent {
    
    public final var collectionView: UICollectionView { return gridComponent.collectionView }
    
}
