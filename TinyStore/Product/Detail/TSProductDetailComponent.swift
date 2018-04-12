//
//  TSProductDetailComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TSProductDetailComponent

import TinyPost
import TinyUI

public final class TSProductDetailComponent: Component {

    private final let bundle: Bundle
    
    /// The base component.
    private final let listComponent: ListComponent

    public final let galleryComponent: UIGalleryComponent

    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    private final let galleryContainerComponent: UIItemComponent<TSProductGalleryView>
    
    public final let descriptionComponent: TSProductDescriptionComponent
    
    public final let reviewSectionHeaderComponent: TSProductSectionHeaderComponent

//    public final let reviewCarouselComponent: UIProductReviewCarouselComponent

    public final var hasIntroductionPost = false
//
//    public final let introductionSectionHeaderComponent: TSProductSectionHeaderComponent
//
//    public final let introductionComponent: UIPostComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        descriptionButtonComponent: UIButtonComponent,
        reviewSectionHeaderComponent: TSProductSectionHeaderComponent
    ) {

        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.listComponent = UIListComponent(contentMode: contentMode)

        self.galleryContainerComponent = UIItemComponent(
            itemView: UIView.load(
                TSProductGalleryView.self,
                from: bundle
            )!
        )
        
        self.galleryComponent = UIGalleryComponent()
        
        self.descriptionComponent = TSProductDescriptionComponent(buttonComponent: descriptionButtonComponent)

        self.reviewSectionHeaderComponent = reviewSectionHeaderComponent

//        self.reviewCarouselComponent = reviewCarouselComponent

//        self.introductionSectionHeaderComponent = TSProductSectionHeaderComponent()
//
//        self.introductionComponent = UIPostComponent(
//            listComponent: UIListComponent()
//        )

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() { galleryContainerComponent.itemView.contentView.wrapSubview(galleryComponent.view) }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return listComponent.contentMode }

        set { listComponent.contentMode = newValue }

    }

    public final func render() {

        let galleryWidth = view.bounds.width

        let galleryHeight = (galleryWidth / galleryAspectRatio)

        galleryContainerComponent.contentMode = .size(
            CGSize(
                width: galleryWidth,
                height: galleryHeight
            )
        )
        
        // TODO: find a way to prevent rendering before list renders it.
        // This is a temporarily fix.
        galleryContainerComponent.render()
        
        galleryComponent.render()

        let reviewWidth = view.bounds.width

//        reviewCarouselComponent.contentMode = .size(
//            CGSize(
//                width: reviewWidth,
//                height: 143.0 + 10.0 // 5.0 points for the shadow.
//            )
//        )

        

        var itemComponents: [Component] = [
            galleryContainerComponent,
            descriptionComponent,
            reviewSectionHeaderComponent,
//            spacingComponentFactory(10.0),
//            reviewCarouselComponent
        ]

//        if hasIntroductionPost {
//
//            itemComponents += [
//                introductionSectionHeaderComponent,
//                spacingComponent(10.0)
//            ]
//
//            listComponent.footerComponent = introductionComponent
//
//        }
//        else { listComponent.footerComponent = nil }

        listComponent.setItemComponents(itemComponents)

        listComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return listComponent.view }

    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }

}

public extension TSProductDetailComponent {
    
    public final func applyTheme(_ theme: Theme) {
        
        galleryContainerComponent.itemView.applyTheme(theme)
        
        descriptionComponent.applyTheme(theme)
        
        reviewSectionHeaderComponent.applyTheme(theme)
        
    }

//    public typealias NumberOfReviewsHandler = UIProductReviewCarouselComponent.NumberOfReviewsHandler

//    @discardableResult
//    public final func setNumberOfReviews(_ handler: NumberOfReviewsHandler?) -> UIProductDetailComponent {
//
//        reviewCarouselComponent.setNumberOfReviews(handler)
//
//        return self
//
//    }

//    public typealias ComponentForReviewHandler = (_ index: Int) -> Component
//
//    @discardableResult
//    public final func setComponentForReview(_ handler: ComponentForReviewHandler?) -> UIProductDetailComponent {
//
//        reviewCarouselComponent.setComponentForReview(handler)
//
//        return self
//
//    }

    @discardableResult
    public final func setIntroductionPost(
        elements: [PostElement]
    )
    -> TSProductDetailComponent {

        hasIntroductionPost = !elements.isEmpty

//        introductionComponent.setPost(elements: elements)

        return self

    }

}
