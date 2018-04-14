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
    
    public final let reviewCarouselComponent: UICarouselComponent
    
    public final let reviewAspectRatio: CGFloat = (3.0 / 2.0)

    public final let introductionSectionHeaderComponent: TSProductSectionHeaderComponent

    public final let introductionComponent: TPPostComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        descriptionButtonComponent: UIButtonComponent,
        reviewSectionHeaderComponent: TSProductSectionHeaderComponent,
        introductionSectionHeaderComponent: TSProductSectionHeaderComponent
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

        self.reviewCarouselComponent = UICarouselComponent()

        self.introductionSectionHeaderComponent = introductionSectionHeaderComponent

        self.introductionComponent = TPPostComponent()

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {
        
        galleryContainerComponent.itemView.contentView.wrapSubview(galleryComponent.view)
        
        reviewCarouselComponent.setMinimumItemWidth { [unowned self] _ in
            
            return (self.reviewCarouselComponent.view.bounds.width / self.reviewAspectRatio)
            
        }
        
        reviewCarouselComponent.collectionView.showsHorizontalScrollIndicator = false
        
    }

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
            reviewCarouselComponent,
        ]

        let hasIntroduction = (introductionComponent.numberOfElements != 0)
        
        if hasIntroduction {

            itemComponents += [ introductionSectionHeaderComponent ]

            listComponent.footerComponent = introductionComponent

        }
        else { listComponent.footerComponent = nil }

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
        
        introductionSectionHeaderComponent.applyTheme(theme)
        
    }

}
