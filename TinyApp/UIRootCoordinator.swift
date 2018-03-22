//
//  UIRootCoordinator.swift
//  TinyKitApp
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyKit

import TinyUI
import TinyPost
import TinyStore

public final class UIRootCoordinator: Coordinator {
    
    /// The navigator.
    private final let rootViewController: UIViewController
    
    private final let containerViewController: UIViewController
    
    private final let productComponent: UIProductDetailComponent
    
    private final let galleryComponent = UIProductGalleryComponent()
    
    private final let actionComponent = UIPrimaryButtonComponent()
    
    private final let reviewSectionHeaderComponent = UIProductSectionHeaderComponent()
    
    private final let reviewCarouselComponent = UIProductReviewCarouselComponent()
    
    private final let introductionSectionHeaderComponent = UIProductSectionHeaderComponent()
    
    private final let reviewComponents: [UIProductReviewComponent]
    
    public init() {
        
        self.reviewComponents = [
            UIProductReviewComponent(
                contentMode: .size(
                    width: 250.0,
                    height: 143.0
                )
            )
            .setPictureImage(#imageLiteral(resourceName: "image-carolyn-simmons"))
            .setTitle("Carolyn Simmons")
            .setText("Etiam porta sem malesuada magna mollis euismod. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui."),
            UIProductReviewComponent(
                contentMode: .size(
                    width: 250.0,
                    height: 143.0
                )
            )
            .setPictureImage(#imageLiteral(resourceName: "image-jerry-price"))
            .setTitle("Jerry Price")
            .setText("Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
            UIProductReviewComponent(
                contentMode: .size(
                    width: 250.0,
                    height: 143.0
                )
            )
            .setPictureImage(#imageLiteral(resourceName: "image-danielle-schneider"))
            .setTitle("Danielle Schneider")
            .setText("Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor.")
        ]
        
        let productComponent = UIProductDetailComponent(
            galleryComponent: galleryComponent,
            actionButtonComponent: actionComponent,
            reviewSectionHeaderComponent: reviewSectionHeaderComponent,
            reviewCarouselComponent: reviewCarouselComponent,
            introductionSectionHeaderComponent: introductionSectionHeaderComponent
        )
        
        self.productComponent = productComponent
        
        let containerViewController = UIComponentViewController(component: productComponent)
        
        self.containerViewController = containerViewController
        
        containerViewController.view.backgroundColor = .white
        
        self.rootViewController = UINavigationController(rootViewController: containerViewController)
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        galleryComponent.setImages(
            [ #imageLiteral(resourceName: "image-dessert-1") ]
        )
        
        actionComponent.setTitle("Add to Cart")
        
        reviewSectionHeaderComponent
            .setIconImage(
                #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
            )
            .setTitle("Reviews")
        
        reviewCarouselComponent
            .numberOfReviews { self.reviewComponents.count }
            .reviewComponentForItem { self.reviewComponents[$0] }
        
        introductionSectionHeaderComponent
            .setIconImage(
                #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
            )
            .setTitle("Inroduction")
        
        productComponent
            .setTitle("Donec id elit non mi porta gravida at eget metus. Sed posuere consectetur est at lobortis. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Sed posuere consectetur est at lobortis.")
            .setSubtitle("Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla.")
            .setIntroductionPost(
                elements: [
                    .text("Sed posuere consectetur est at lobortis. Seosuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis dapibus posuere elit aliquet. Lorem ipsum dolor sit amet, coctetur adipiscing."),
                    .image(#imageLiteral(resourceName: "image-product-story-1")),
                    .image(#imageLiteral(resourceName: "image-product-story-2")),
                    .text("Etiam porta sem malesuada magna mollis euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                    .image(#imageLiteral(resourceName: "image-product-story-3")),
                    .image(#imageLiteral(resourceName: "image-product-story-4"))
                ]
        )
        
        productComponent.render()
        
    }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return rootViewController }
    
}
