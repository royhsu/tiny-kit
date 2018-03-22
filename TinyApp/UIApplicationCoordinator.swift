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
        
        let productDetailCoordinator = UIProductDetailCoordinator(
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
            ),
            provider: ProductManager()
        )
        
        self.rootCoordinator = productDetailCoordinator
        
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
