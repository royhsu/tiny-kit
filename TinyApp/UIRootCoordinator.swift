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
    
    public init() {
        
        let productComponent = UIProductDetailComponent(
            listComponent: UINewListComponent(),
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
        
        productComponent.render()
        
    }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return rootViewController }
    
}
