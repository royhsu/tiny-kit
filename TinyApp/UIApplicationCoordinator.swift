//
//  UIApplicationCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIApplicationCoordinator

import TinyPost
import TinyStore

import TinyAuth

public final class UIApplicationCoordinator: Coordinator {

    /// The navigator.
    private final let window: UIWindow

    public typealias RootCoordinator = Coordinator & ViewControllerRepresentable

    private final var rootCoordinator: RootCoordinator
    
    public init(contentSize: CGSize) {

        self.window = TestWindow(
            frame: CGRect(
                origin: .zero,
                size: contentSize
            )
        )
        
//        self.rootCoordinator = UIHomeNavigationCoordinator()
        
//        self.rootCoordinator = UIRootCoordinator()
        
        let productDetailCoordinator = ProductDetailCoordinator(
            component: UIProductDetailComponent(
                galleryComponent: UIProductGalleryComponent(),
                actionButtonComponent: UIPrimaryButtonComponent()
                    .setTitle("Add to Cart")
                    .setAction { print("Add the item to my cart.") },
                reviewSectionHeaderComponent: UIProductSectionHeaderComponent()
                    .setIconImage(
                        #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
                    )
                    .setTitle("Reviews"),
                reviewCarouselComponent: UIProductReviewCarouselComponent(),
                introductionSectionHeaderComponent: UIProductSectionHeaderComponent()
                    .setIconImage(
                        #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
                    )
                    .setTitle("Introduction")
            )
        )
        
        self.rootCoordinator = productDetailCoordinator
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            productDetailCoordinator.storage.title.value = "Donec id elit non mi porta gravida at eget metus. Sed posuere consectetur est at lobortis. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Sed posuere consectetur est at lobortis."
            
            productDetailCoordinator.storage.subtitle.value = "Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla."
            
            productDetailCoordinator.storage.reviews.value = [
                (
                    title: "Carolyn Simmons",
                    text: "Etiam porta sem malesuada magna mollis euismod. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui."
                ),
                (
                    title: "Jerry Price",
                    text: "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ),
                (
                    title: "Danielle Schneider",
                    text: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor."
                )
            ]
            
            productDetailCoordinator.storage.introductionPost.value = Post(
                elements: [
                    .text("Sed posuere consectetur est at lobortis. Seosuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis dapibus posuere elit aliquet. Lorem ipsum dolor sit amet, coctetur adipiscing."),
                    .image(#imageLiteral(resourceName: "image-product-story-1")),
                    .image(#imageLiteral(resourceName: "image-product-story-2")),
                    .text("Etiam porta sem malesuada magna mollis euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                    .image(#imageLiteral(resourceName: "image-product-story-3")),
                    .image(#imageLiteral(resourceName: "image-product-story-4"))
                ]
            )
            
        }
        
    }

    public final func activate() {

        window.rootViewController = rootCoordinator.viewController
        
        window.makeKeyAndVisible()

        rootCoordinator.activate()

    }

}

// For debugging touch events.
public final class TestWindow: UIWindow {
    
    public override func sendEvent(_ event: UIEvent) {
        
        event.touches(for: self)?.forEach { touch in
            
            let point = touch.location(in: self)
            
            let view = hitTest(
                point,
                with: event
            )

        }
        
        super.sendEvent(event)
        
    }
    
}
