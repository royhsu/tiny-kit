//
//  UIProductDetailComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDetailComponent

import TinyPost
import TinyUI

public final class UIProductDetailComponent: Component {
    
    /// The base component.
    private final let listComponent: ListComponent
    
    public final let galleryComponent: UIProductGalleryComponent
    
    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    internal final let descriptionComponent: UIProductDescriptionComponent
    
    public final let reviewSectionHeaderComponent: UIProductSectionHeaderComponent
    
    public final let reviewCarouselComponent: UIProductReviewCarouselComponent
    
    public final var hasIntroductionPost = false
    
    public final let introductionSectionHeaderComponent: UIProductSectionHeaderComponent
    
    public final let introductionComponent: UIPostComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        listComponent: ListComponent,
        galleryComponent: UIProductGalleryComponent,
        actionButtonComponent: UIPrimaryButtonComponent,
        reviewSectionHeaderComponent: UIProductSectionHeaderComponent,
        reviewCarouselComponent: UIProductReviewCarouselComponent,
        introductionSectionHeaderComponent: UIProductSectionHeaderComponent
    ) {
        
        listComponent.contentMode = contentMode
        
        self.listComponent = listComponent
        
        self.galleryComponent = galleryComponent
        
        self.descriptionComponent = UIProductDescriptionComponent(actionButtonComponent: actionButtonComponent)
        
        self.reviewSectionHeaderComponent = reviewSectionHeaderComponent
        
        self.reviewCarouselComponent = reviewCarouselComponent
        
        self.introductionSectionHeaderComponent = introductionSectionHeaderComponent
        
        self.introductionComponent = UIPostComponent(
            listComponent: UIListComponent()
        )
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() { }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let galleryWidth = view.bounds.width
        
        let galleryHeight = (galleryWidth / galleryAspectRatio)
        
        galleryComponent.contentMode = .size(
            width: galleryWidth,
            height: galleryHeight
        )
        
        let reviewWidth = view.bounds.width
        
        reviewCarouselComponent.contentMode = .size(
            width: reviewWidth,
            height: 143.0 + 10.0 // 5.0 points for the shadow.
        )
        
        let spacingComponent: (CGFloat) -> Component = { spacing in
            
            return UIItemComponent(
                contentMode: .size(
                    width: spacing,
                    height: spacing
                ),
                itemView: UIView()
            )
            
        }
        
        var itemComponents: [Component] = [
            galleryComponent,
            spacingComponent(20.0),
            descriptionComponent,
            spacingComponent(10.0),
            reviewSectionHeaderComponent,
            spacingComponent(10.0),
            reviewCarouselComponent
        ]
        
        if hasIntroductionPost {
            
            itemComponents += [
                introductionSectionHeaderComponent,
                spacingComponent(10.0)
            ]
            
            listComponent.setFooterComponent(introductionComponent)
            
        }
        else { listComponent.setFooterComponent(nil)  }
        
        listComponent
            .setItemComponents(itemComponents)
            .render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

public extension UIProductDetailComponent {
    
    @discardableResult
    public final func setGallery(
        _ images: [UIImage]
    )
    -> UIProductDetailComponent {
        
        galleryComponent.setImages(images)
        
        return self
            
    }
    
    @discardableResult
    public final func setTitle(_ title: String?) -> UIProductDetailComponent {
        
        descriptionComponent.setTitle(title)
        
        return self
        
    }
    
    @discardableResult
    public final func setSubtitle(_ subtitle: String?) -> UIProductDetailComponent {
        
        descriptionComponent.setSubtitle(subtitle)
        
        return self
        
    }
    
    public typealias NumberOfReviewsHandler = UIProductReviewCarouselComponent.NumberOfReviewsHandler
    
    @discardableResult
    public final func setNumberOfReviews(_ handler: NumberOfReviewsHandler?) -> UIProductDetailComponent {
        
        reviewCarouselComponent.setNumberOfReviews(handler)
        
        return self
        
    }
    
    public typealias ComponentForReviewHandler = (_ index: Int) -> Component
    
    @discardableResult
    public final func setComponentForReview(_ handler: ComponentForReviewHandler?) -> UIProductDetailComponent {
        
        reviewCarouselComponent.setComponentForReview(handler)
        
        return self
        
    }
    
    @discardableResult
    public final func setIntroductionPost(
        elements: [PostElement]
    )
    -> UIProductDetailComponent {
        
        hasIntroductionPost = !elements.isEmpty
            
        introductionComponent.setPost(elements: elements)
        
        return self
        
    }
    
}
