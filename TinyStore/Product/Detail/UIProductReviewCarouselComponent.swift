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
        
//        let sections = collectionComponent.itemComponents.numberOfSections()
//
//        for section in 0..<sections {
//
//            let items = collectionComponent.itemComponents.numberOfItems(inSection: section)
//
//            for item in 0..<items {
//
//                let indexPath = IndexPath(
//                    item: item,
//                    section: section
//                )
//
//                var itemComponent = collectionComponent.itemComponents.componentForItem(at: indexPath)
//
//                itemComponent.contentMode = .size(
//                    width: 250.0,
//                    height: 143.0
//                )
//
//            }
//
//        }
        
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
        
//        let components: [Component] = reviews.map { review in
//            
//            let component = UIProductReviewComponent(
//                contentMode: .size(
//                    width: 0.0,
//                    height: 0.0
//                ) // Prevent the size of an item greater than the collection view, that will raise an exception.
//            )
//            
//            component.setReview(review)
//            
//            return component
//            
//        }
//        
//        collectionComponent.itemComponents = AnyCollection(components)
        
        return self
        
    }
    
}
