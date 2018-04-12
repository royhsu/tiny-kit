//
//  TSProductReviewCarouselComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductReviewCarouselComponent

//public final class TSProductReviewCarouselComponent: Component {
//
//    /// The base component.
//    private final let carouselComponent: UICarouselComponent
//
//    public init(contentMode: ComponentContentMode = .automatic) {
//
//        self.carouselComponent = UICarouselComponent(contentMode: contentMode)
//
//        self.numberOfReviews = 0
//        
//        self.prepare()
//
//    }
//
//    // MARK: Set Up
//
//    fileprivate final func prepare() {
//        
//        carouselComponent.numberOfSections = 1
//        
//        carouselComponent.setNumberOfItemComponents { [unowned self] _ in self.numberOfReviews }
//        
//        carouselComponent.setItemComponent { [unowned self] indexPath in
//            
//            let reviewComponent = self.reviewComponentProvider?(indexPath)
//            
//            return itemComponent
//            
//        }
////
//        collectionComponent
//            .setNumberOfSections { 1 }
//            .setNumberOfItems { _ in
//
//                let items = self.numberOfReviewsHandler?()
//
//                return items ?? 0
//
//            }
//            .setComponentForItem { indexPath in
//
//                let component = self.componentForReviewHandler?(indexPath.item)
//
//                return component
//
//            }
//
//    }

    // MARK: Component

//    public final var contentMode: ComponentContentMode {
//
//        get { return carouselComponent.contentMode }
//
//        set { carouselComponent.contentMode = newValue }
//
//    }
//
//    public final func render() {
//
//        collectionComponent.scrollDirection = .horizontal
//
//        collectionComponent.collectionLayout.minimumLineSpacing = 16.0
//
//        collectionComponent.collectionLayout.sectionInset = UIEdgeInsets(
//            top: 0.0,
//            left: 16.0,
//            bottom: 10.0, // For the shadow.
//            right: 16.0
//        )
//
//        collectionComponent.collectionView.backgroundColor = .white
//
//        collectionComponent.collectionView.clipsToBounds = false
//
//        collectionComponent.collectionView.showsHorizontalScrollIndicator = false
//
//        collectionComponent.collectionView.showsVerticalScrollIndicator = false
//
//        collectionComponent.render()
//
//    }

    // MARK: ViewRenderable
//
//    public final var view: View { return carouselComponent.view }
//
//    public final var preferredContentSize: CGSize { return carouselComponent.preferredContentSize }

    // MARK: Review

//    public final var numberOfReviews: Int
//
//    public typealias ReviewComponentProvider = (_ index: Int) -> Component
//
//    private final var reviewComponentProvider: ReviewComponentProvider?
//
//    public final func setReviewComponent(provider: @escaping ReviewComponentProvider) { reviewComponentProvider = provider }
//
//}
//
//public extension TSProductReviewCarouselComponent {
//
//    public final func setReviewComponents(
//        _ components: [Component]
//    ) {
//
//        numberOfReviews = components.count
//
//        setReviewComponent { index in components[index] }
//
//    }
//
//}
