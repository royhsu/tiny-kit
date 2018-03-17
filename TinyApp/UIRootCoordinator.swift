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
//    private final let rootViewController: UIViewController
    
    public init(contentSize: CGSize) {
        
//        cartItemListComponent.setItems(
//            [
//                UICartItem(
//                    previewImage: #imageLiteral(resourceName: "image-dessert-3"),
//                    title: "Nullam quis risus eget urna mollis ornare vel eu leo. Vestibulum id ligula porta felis euismod semper.",
//                    price: 150.0
//                ),
//                UICartItem(
//                    previewImage: #imageLiteral(resourceName: "image-dessert-1"),
//                    title: "Cras mattis consectetur purus sit amet fermentum.",
//                    price: 120.0
//                )
//            ]
//        )
        
//        let rootComponent = UIProductDetailComponent(
//            contentMode: .size(
//                width: contentSize.width,
//                height: contentSize.height
//            )
//        )
//        .setGallery(
//            UIProductGallery(
//                images: [ #imageLiteral(resourceName: "image-dessert-1") ]
//            )
//        )
//        .setDescription(
//            UIProductDescription(
//                title: "Donec id elit non mi porta gravida at eget metus. Sed posuere consectetur est at lobortis. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Sed posuere consectetur est at lobortis.",
//                subtitle: "Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla."
//
//            )
//        )
//        .setActionButtonItem(
//            UIPrimaryButtonItem(
//                title: "Add to Cart",
//                titleColor: .white,
//                iconImage: #imageLiteral(resourceName: "icon-add").withRenderingMode(.alwaysTemplate),
//                backgroundColor: UIColor(
//                    red: 0.35,
//                    green: 0.56,
//                    blue: 0.87,
//                    alpha: 1.0
//                )
//            )
//        )
//        .setReviews(
//            [
//                UIProductReview(
//                    pictureImage: #imageLiteral(resourceName: "image-carolyn-simmons"),
//                    title: "Carolyn Simmons",
//                    content: "Etiam porta sem malesuada magna mollis euismod. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui."
//                ),
//                UIProductReview(
//                    pictureImage: #imageLiteral(resourceName: "image-jerry-price"),
//                    title: "Jerry Price",
//                    content: "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
//                ),
//                UIProductReview(
//                    pictureImage: #imageLiteral(resourceName: "image-danielle-schneider"),
//                    title: "Danielle Schneider",
//                    content: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor."
//                )
//            ]
//        )
//        .setPost(
//            elements: [
//                UIPostParagraph(content: "Sed posuere consectetur est at lobortis. Seosuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis dapibus posuere elit aliquet. Lorem ipsum dolor sit amet, coctetur adipiscing."),
//                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-1")),
//                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-2")),
//                UIPostParagraph(content: "Etiam porta sem malesuada magna mollis euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
//                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-3")),
//                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-4")),
//            ]
//        )
        
//        let rootComponent = UIGridComponent(
//            contentMode: .size(
//                width: contentSize.width,
//                height: contentSize.height
//            )
//        )
        
//        self.rootComponent = gridComponent
//
//        let tabBarController = UITabBarController(
//            nibName: nil,
//            bundle: nil
//        )
        
//        let componentViewController = UIComponentViewController(component: rootComponent)
//
//        componentViewController.tabBarItem = UITabBarItem(
//            tabBarSystemItem: .featured,
//            tag: 0
//        )
//
//        let collapseBarController = UICollapseBarController()
//
//        collapseBarController.tabBarItem = UITabBarItem(
//            tabBarSystemItem: .featured,
//            tag: 0
//        )
//
//        collapseBarController.setBackgroundViewController(
//            componentViewController
//        )
//

//
//        collapseBarController.setBarViewController(
//            UIComponentViewController(component: cartBarComponent)
//        )
//
//        collapseBarController.setBarContentViewController(
//            UIComponentViewController(component: cartItemListComponent)
//        )
        
//        tabBarController.setViewControllers(
//            [ collapseBarController ],
//            animated: true
//        )
//
//        self.rootViewController = tabBarController
        
    }
    
    public final func activate() {
        
//        rootComponent.render()
//
//        cartBarComponent.render()
//
//        cartItemListComponent.render()
//
    }
    
}

// MARK: - ViewRenderable

//extension UIRootCoordinator: ViewControllerRepresentable {
//    
//    public final var viewController: ViewController { return rootViewController }
//    
//}

