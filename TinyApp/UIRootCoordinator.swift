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
    
    private final let rootComponent: Component
    
    public init() {
        
        let productComponent = UIProductDetailComponent()
        
        self.rootComponent = productComponent
        
        let containerViewController = UIComponentViewController(component: rootComponent)
        
        containerViewController.view.backgroundColor = .white
        
        self.rootViewController = containerViewController
        
        productComponent.setPost(
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
    
    public final func activate() { rootComponent.render() }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return rootViewController }
    
}
