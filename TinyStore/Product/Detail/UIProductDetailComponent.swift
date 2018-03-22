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
    private final let listComponent: UIListComponent
    
    private final var itemComponents: [Component]
    
    public final let galleryComponent: UIProductGalleryComponent
    
    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    internal final let descriptionComponent: UIProductDescriptionComponent
    
    public final let reviewCarouselComponent: UIProductReviewCarouselComponent
    
    public final let postComponent: UIPostComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        galleryComponent: UIProductGalleryComponent,
        actionButtonComponent: UIPrimaryButtonComponent,
        reviewCarouselComponent: UIProductReviewCarouselComponent
    ) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.itemComponents = []
        
        self.galleryComponent = galleryComponent
        
        self.descriptionComponent = UIProductDescriptionComponent(actionButtonComponent: actionButtonComponent)
        
        self.reviewCarouselComponent = reviewCarouselComponent
        
        self.postComponent = UIPostComponent()
        
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
        
        itemComponents = [
            galleryComponent,
            spacingComponent(20.0),
            descriptionComponent,
            spacingComponent(10.0),
            UIProductSectionHeaderComponent().setTitle("Reviews"),
            spacingComponent(10.0),
            reviewCarouselComponent
        ]
        
        if postComponent.elementComponents.isEmpty { listComponent.setFooterComponent(nil) }
        else {
            
            itemComponents += [
                spacingComponent(10.0),
                UIProductSectionHeaderComponent().setTitle("Introduction"),
                spacingComponent(10.0)
            ]
            
            listComponent.setFooterComponent(postComponent)
            
        }
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

public extension UIProductDetailComponent {
    
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
    
    @discardableResult
    public final func setPost(
        elements: [PostElement]
    )
    -> UIProductDetailComponent {
            
        postComponent.setPost(elements: elements)
        
        return self
        
    }
    
}
