//
//  UIProductReviewCarouselComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductReviewCarouselComponent

public final class UIProductReviewCarouselComponent: Component {
    
    /// The base component.
    private final let collectionComponent: UICollectionComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.collectionComponent = UICollectionComponent(contentMode: contentMode)
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        collectionComponent
            .setNumberOfSections { 1 }
            .setNumberOfItems { _ in
                
                let items = self.numberOfReviewsHandler?()
                
                return items ?? 0
                
            }
            .setComponentForItem { indexPath in
                
                let component = self.componentForReviewHandler?(indexPath.item)
                
                return component
                
            }
    
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return collectionComponent.contentMode }
        
        set { collectionComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        collectionComponent.scrollDirection = .horizontal
        
        collectionComponent.collectionLayout.minimumLineSpacing = 16.0
        
        collectionComponent.collectionLayout.sectionInset = UIEdgeInsets(
            top: 0.0,
            left: 16.0,
            bottom: 10.0, // For the shadow.
            right: 16.0
        )
        
        collectionComponent.collectionView.backgroundColor = .white
        
        collectionComponent.collectionView.clipsToBounds = false
        
        collectionComponent.collectionView.showsHorizontalScrollIndicator = false
        
        collectionComponent.collectionView.showsVerticalScrollIndicator = false
        
        collectionComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionComponent.view }
    
    public final var preferredContentSize: CGSize { return collectionComponent.preferredContentSize }
    
    // MARK: Action
    
    public typealias NumberOfReviewsHandler = () -> Int
    
    private final var numberOfReviewsHandler: NumberOfReviewsHandler?
    
    public typealias ComponentForReviewHandler = (_ index: Int) -> Component
    
    private final var componentForReviewHandler: ComponentForReviewHandler?
    
}

public extension UIProductReviewCarouselComponent {
    
    @discardableResult
    public final func setNumberOfReviews(_ handler: NumberOfReviewsHandler?) -> UIProductReviewCarouselComponent {
        
        numberOfReviewsHandler = handler
        
        return self
        
    }
    
    @discardableResult
    public final func setComponentForReview(_ handler: ComponentForReviewHandler?) -> Component {
        
        componentForReviewHandler = handler
        
        return self
        
    }
    
}
