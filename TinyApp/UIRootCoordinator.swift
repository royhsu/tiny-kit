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
        
        let galleyComponent = UIGalleryComponent()
        
        galleyComponent.setImageContainer(
            [
                ImageContainer.image(#imageLiteral(resourceName: "image-dessert-1")),
                ImageContainer.image(#imageLiteral(resourceName: "image-dessert-2")),
                ImageContainer.image(#imageLiteral(resourceName: "image-dessert-3"))
            ]
        )
        
        let boxComponent = UIBoxComponent(
            contentMode: .size(
                CGSize(
                    width: 414.0,
                    height: 200.0
                )
            ),
            contentComponent: galleyComponent
        )
        
        boxComponent.paddingInsets = UIEdgeInsets(
            top: 10.0,
            left: 10.0,
            bottom: 10.0,
            right: 10.0
        )
        
        boxComponent.view.backgroundColor = .green
        
        let listComponent = UIListComponent()
        
        listComponent.setItemComponents(
            [ boxComponent ]
        )

        let viewController = UIComponentViewController(component: listComponent)

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
