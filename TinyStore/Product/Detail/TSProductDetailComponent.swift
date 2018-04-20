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
    private final let layoutComponent: ListComponent

    public final let galleryComponent: UIGalleryComponent

    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    private final let galleryContainerComponent: UIItemComponent<TSProductGalleryView>
    
    public final let descriptionComponent: TSProductDescriptionComponent
    
    public final let reviewSectionHeaderComponent: TSProductSectionHeaderComponent
    
    public final let reviewCarouselComponent: UICarouselComponent
    
    public final let reviewAspectRatio: CGFloat = (3.0 / 2.0)

    public final let introductionSectionHeaderComponent: TSProductSectionHeaderComponent

    public final let introductionComponent: PostComponent

    public init(
        layoutComponent: ListComponent,
        descriptionButtonComponent: UIButtonComponent,
        reviewSectionHeaderComponent: TSProductSectionHeaderComponent,
        introductionSectionHeaderComponent: TSProductSectionHeaderComponent,
        introductionComponent: PostComponent
    ) {

        self.bundle = Bundle(
            for: type(of: self)
        )
        
        self.layoutComponent = layoutComponent

        self.galleryContainerComponent = UIItemComponent(
            itemView: UIView.load(
                TSProductGalleryView.self,
                from: bundle
            )!
        )
        
        self.galleryComponent = UIGalleryComponent()
        
        self.descriptionComponent = TSProductDescriptionComponent(buttonComponent: descriptionButtonComponent)

        self.reviewSectionHeaderComponent = reviewSectionHeaderComponent

        self.reviewCarouselComponent = UICarouselComponent()

        self.introductionSectionHeaderComponent = introductionSectionHeaderComponent

        self.introductionComponent = introductionComponent

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {
        
        galleryContainerComponent.itemView.contentView.wrapSubview(galleryComponent.view)
        
        reviewCarouselComponent.setMinimumItemWidth { [unowned self] component, _ in
            
            return (component.view.bounds.width / self.reviewAspectRatio)
            
        }
        
        reviewCarouselComponent.collectionView.showsHorizontalScrollIndicator = false
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return layoutComponent.contentMode }

        set { layoutComponent.contentMode = newValue }

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
        
        reviewCarouselComponent.contentMode = .size(
            CGSize(
                width: view.bounds.width,
                height: 167.0
            )
        )

        reviewCarouselComponent.render()
        
        var itemComponents: [Component] = [
            galleryContainerComponent,
            descriptionComponent,
            reviewSectionHeaderComponent,
//            reviewCarouselComponent,
        ]

        let hasIntroduction = (introductionComponent.numberOfElements != 0)
        
        if hasIntroduction {

            let components: [Component] = [ introductionSectionHeaderComponent, introductionComponent ]
            
            itemComponents += components
            
//            itemComponents += [ introductionSectionHeaderComponent ]

//            layoutComponent.footerComponent = introductionComponent

        }
        else { layoutComponent.footerComponent = nil }

        layoutComponent.setItemComponents(itemComponents)

        layoutComponent.render()

    }

    // MARK: ViewRenderable

    public final var view: View { return layoutComponent.view }

    public final var preferredContentSize: CGSize { return layoutComponent.preferredContentSize }

}

public extension TSProductDetailComponent {
    
    public final func applyTheme(_ theme: Theme) {
        
        galleryContainerComponent.itemView.applyTheme(theme)
        
        descriptionComponent.applyTheme(theme)
        
        reviewSectionHeaderComponent.applyTheme(theme)
        
        introductionSectionHeaderComponent.applyTheme(theme)
        
    }

}
