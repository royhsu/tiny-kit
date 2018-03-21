//
//  UIProductDetailHeaderComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDetailHeaderComponent

import TinyUI

internal final class UIProductDetailHeaderComponent: Component {
    
    /// The base component.
    private final let listComponent: UIListComponent
    
    private final var itemComponents: [Component]
    
    internal final let galleryComponent: UIProductGalleryComponent
    
    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    internal final let descriptionComponent: UIProductDescriptionComponent
    
    internal final let reviewCarouselComponent: UIProductReviewCarouselComponent
    
    internal init(
        contentMode: ComponentContentMode = .automatic,
        actionButtonComponent: UIPrimaryButtonComponent,
        reviewCarouselComponent: UIProductReviewCarouselComponent
    ) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.itemComponents = []
        
        self.galleryComponent = UIProductGalleryComponent()
        
        self.descriptionComponent = UIProductDescriptionComponent(actionButtonComponent: actionButtonComponent)
        
        self.reviewCarouselComponent = reviewCarouselComponent
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        listComponent
            .setNumberOfSections { 1 }
            .setNumberOfItems { _ in self.itemComponents.count }
            .setComponentForItem { self.itemComponents[$0.item] }
        
    }
    
    // MARK: Component
    
    internal final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    internal final func render() {
        
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
        
        itemComponents = [
            galleryComponent,
            spacingComponent(20.0),
            descriptionComponent,
            spacingComponent(20.0),
//            UIProductSectionHeaderComponent().setHeader(
//                UIProductSectionHeader(
//                    iconImage: #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate),
//                    title: "Reviews"
//                )
//            ),
//            spacingComponent(20.0),
            reviewCarouselComponent
        ]
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    internal final var view: View { return listComponent.view }
    
    internal final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}
