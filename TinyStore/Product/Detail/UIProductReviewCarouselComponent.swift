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
    
    private final var reviewComponents: [Component]
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.collectionComponent = UICollectionComponent(contentMode: contentMode)
        
        self.reviewComponents = []
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        collectionComponent
            .setNumberOfSections { 1 }
            .setNumberOfItems { _ in self.reviewComponents.count }
            .setComponentForItem { self.reviewComponents[$0.item] }
    
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return collectionComponent.contentMode }
        
        set { collectionComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        collectionComponent.view.backgroundColor = .white
        
        collectionComponent.scrollDirection = .horizontal
        
        collectionComponent.collectionLayout.minimumLineSpacing = 16.0
        
        collectionComponent.collectionLayout.sectionInset = UIEdgeInsets(
            top: 0.0,
            left: 16.0,
            bottom: 0.0,
            right: 16.0
        )
        
        collectionComponent.collectionView.showsHorizontalScrollIndicator = false
        
        collectionComponent.collectionView.showsVerticalScrollIndicator = false
        
        collectionComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionComponent.view }
    
    public final var preferredContentSize: CGSize { return collectionComponent.preferredContentSize }
    
}

public extension UIProductReviewCarouselComponent {

    @discardableResult
    public final func setReviews(
        _ reviews: [UIProductReview]
    )
    -> UIProductReviewCarouselComponent {
        
        reviewComponents = reviews.map { review in
            
            return UIProductReviewComponent(
                contentMode: .size(
                    width: 250.0,
                    height: 143.0
                )
            )
            .setReview(review)
            
        }
        
        return self
        
    }
    
}
