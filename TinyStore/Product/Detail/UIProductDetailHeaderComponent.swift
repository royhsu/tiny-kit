//
//  UIProductDetailHeaderComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDetailHeaderComponent

public final class UIProductDetailHeaderComponent: Component {
    
    /// The base component.
    private final let listComponent: UIListComponent
    
    private final let galleryComponent: UIProductGalleryComponent
    
    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    private final let descriptionComponent: UIProductDescriptionComponent
    
    private final let reviewCarouselComponent: UIProductReviewCarouselComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.galleryComponent = UIProductGalleryComponent()
        
        self.descriptionComponent = UIProductDescriptionComponent()
        
        self.reviewCarouselComponent = UIProductReviewCarouselComponent()
        
    }
    
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
        
        let reviewCarouselWidth = view.bounds.width
        
        reviewCarouselComponent.contentMode = .size(
            width: reviewCarouselWidth,
            height: 143.0 + 20.0 // Shadow
        )
        
        listComponent.itemComponents = AnyCollection(
            [
                galleryComponent,
                makeSpacingComponent(spacing: 20.0),
                descriptionComponent,
                makeSpacingComponent(spacing: 20.0),
                UIProductSectionHeaderComponent(
                    contentMode: .size(
                        width: 20.0,
                        height: 20.0
                    )
                )
                .setHeader(
                    UIProductSectionHeader(
                        iconImage: #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate),
                        title: "Reviews"
                    )
                ),
                makeSpacingComponent(spacing: 20.0),
                reviewCarouselComponent
            ]
        )
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
    // MARK: Component Factory
    
    fileprivate final func makeSpacingComponent(spacing: CGFloat) -> UIItemComponent<UIView> {
        
        return UIItemComponent(
            contentMode: .size(
                width: spacing,
                height: spacing
            ),
            itemView: UIView()
        )
        
    }
    
}

public extension UIProductDetailHeaderComponent {
    
    @discardableResult
    public final func setGallery(_ gallery: UIProductGallery) -> UIProductDetailHeaderComponent {
        
        galleryComponent.setGallery(gallery)
        
        return self
        
    }
    
    @discardableResult
    public final func setDescription(_ description: UIProductDescription) -> UIProductDetailHeaderComponent {
        
        descriptionComponent.setDescription(description)
        
        return self
        
    }
    
    @discardableResult
    public final func setReviews(
        _ reviews: [UIProductReview]
    )
    -> UIProductDetailHeaderComponent {
        
        reviewCarouselComponent.setReviews(reviews)
        
        return self
            
    }
    
}
