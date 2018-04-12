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
    
    private final var listening: NewEventEmitter<UITouchEvent>.Listening?
    
    public init() {

//        let postComponent = UIPostComponent(
//            listComponent: UIListComponent()
//        )
//        .setPost(
//            elements: [
//                .text("Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna, vel scelerisque nisl consectetur et."),
//                .text("Donec ullamcorper nulla non metus auctor fringilla. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor.")
//            ]
//        )
//
//        let listComponent = UIListComponent()
//
//        listComponent.setItemComponents(
//            [ postComponent ]
//        )
        
        let buttonComponent = TSPrimaryButtonComponent()
        
        buttonComponent.titleLabel.text = "Add to Cart"
        
        buttonComponent.iconImageView.image = #imageLiteral(resourceName: "icon-plus").withRenderingMode(.alwaysTemplate)
        
        buttonComponent.applyTheme(.current)
        
        listening = buttonComponent.eventEmitter.listen(event: .touchUpInside) { event in
            
            print("emitted", event)
            
        }
        
        let productDetailComponent = TSProductDetailComponent(
            descriptionButtonComponent: buttonComponent
        )
        
        productDetailComponent.galleryComponent.setImageContainers(
            [
                ImageContainer.image(#imageLiteral(resourceName: "image-dessert-1")),
                ImageContainer.image(#imageLiteral(resourceName: "image-dessert-2")),
                ImageContainer.image(#imageLiteral(resourceName: "image-dessert-3"))
            ]
        )
        
        productDetailComponent.descriptionComponent.titleLabel.text = "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."
        
        productDetailComponent.descriptionComponent.subtitleLabel.text = "$12.99"
        
        productDetailComponent.descriptionComponent.paddingInsets = UIEdgeInsets(
            top: 16.0,
            left: 16.0,
            bottom: 16.0,
            right: 16.0
        )
        
        productDetailComponent.applyTheme(.current)
        
        let viewController = UIComponentViewController(component: productDetailComponent)

        viewController.view.backgroundColor = .white

        self.rootViewController = UINavigationController(rootViewController: viewController)

    }

    // MARK: Coordinator

    public final func activate() { }

}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {

    public final var viewController: ViewController { return rootViewController }

}
