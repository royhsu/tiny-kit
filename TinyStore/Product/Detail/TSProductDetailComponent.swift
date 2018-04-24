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

    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    public final let galleryComponent: TSProductGalleryComponent
    
    public final let descriptionComponent: TSProductDescriptionComponent
    
    public final let reviewSectionHeaderComponent: TSProductSectionHeaderComponent
    
    public final let reviewAspectRatio: CGFloat = (3.0 / 2.0)
    
    public final let reviewCarouselComponent: UICarouselComponent

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

        self.galleryComponent = TSProductGalleryComponent()
        
        self.descriptionComponent = TSProductDescriptionComponent(buttonComponent: descriptionButtonComponent)

        self.reviewSectionHeaderComponent = reviewSectionHeaderComponent

        self.reviewCarouselComponent = UICarouselComponent()

        self.introductionSectionHeaderComponent = introductionSectionHeaderComponent

        self.introductionComponent = introductionComponent

        self.prepare()

    }

    // MARK: Set Up

    fileprivate final func prepare() {
        
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
        
        let width = contentMode.initialSize.width

        galleryComponent.contentMode = .size(
            CGSize(
                width: width,
                height: (width / galleryAspectRatio)
            )
        )
       
        descriptionComponent.contentMode = .automatic(
            estimatedSize: CGSize(
                width: width,
                height: 100.0
            )
        )
        
//        reviewCarouselComponent.contentMode = .size(
//            CGSize(
//                width: view.bounds.width,
//                height: 167.0
//            )
//        )

//        reviewCarouselComponent.render()
        
        var itemComponents: [Component] = [
            galleryComponent,
            descriptionComponent,
            reviewSectionHeaderComponent,
//            reviewCarouselComponent
        ]

        let hasIntroduction = (introductionComponent.numberOfElements != 0)

        if hasIntroduction {

            itemComponents += [ introductionSectionHeaderComponent ]
            
            introductionComponent.contentMode = .automatic(
                estimatedSize: CGSize(
                    width: width,
                    height: 100.0
                )
            )
            
            layoutComponent.footerComponent = introductionComponent

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
        
        galleryComponent.applyTheme(theme)
        
        descriptionComponent.applyTheme(theme)
        
        reviewSectionHeaderComponent.applyTheme(theme)
        
        introductionSectionHeaderComponent.applyTheme(theme)
        
    }

}
