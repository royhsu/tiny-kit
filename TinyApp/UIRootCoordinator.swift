//
//  UIRootCoordinator.swift
//  TinyKitApp
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyKit

import TinyPost
import TinyStore

public final class UIRootCoordinator: Coordinator {
    
    private final let navigationController: UINavigationController
    
    private final let rootComponent: Component
    
    public init(contentSize: CGSize) {
        
        let rootComponent = UIProductDetailComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )
        .setGallery(
            UIProductGallery(
                images: [ #imageLiteral(resourceName: "image-dessert-1") ]
            )
        )
        .setDescription(
            UIProductDescription(
                title: "Donec id elit non mi porta gravida at eget metus. Sed posuere consectetur est at lobortis. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Sed posuere consectetur est at lobortis.",
                subtitle: "Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla."

            )
        )
        .setReviews(
            [
                UIProductReview(
                    pictureImage: #imageLiteral(resourceName: "image-carolyn-simmons"),
                    title: "Carolyn Simmons",
                    content: "Etiam porta sem malesuada magna mollis euismod. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Donec ullamcorper nulla non metus auctor fringilla. Donec sed odio dui."
                ),
                UIProductReview(
                    pictureImage: #imageLiteral(resourceName: "image-jerry-price"),
                    title: "Jerry Price",
                    content: "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                )
            ]
        )
        .setPost(
            elements: [
                UIPostParagraph(content: "Sed posuere consectetur est at lobortis. Seosuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis dapibus posuere elit aliquet. Lorem ipsum dolor sit amet, coctetur adipiscing."),
                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-1")),
                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-2")),
                UIPostParagraph(content: "Etiam porta sem malesuada magna mollis euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-3")),
                UIPostImage(image: #imageLiteral(resourceName: "image-product-story-4")),
            ]
        )
        
//        let rootComponent = UIGridComponent(
//            contentMode: .size(
//                width: contentSize.width,
//                height: contentSize.height
//            )
//        )
//
//        rootComponent.setItems(
//            [
//                UIGridItem(
//                    previewImages: [ #imageLiteral(resourceName: "image-dessert-1") ],
//                    title: "Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
//                    subtitle: "Integer posuere erat a ante venenatis dapibus posuere velit aliquet."
//                ),
//                UIGridItem(
//                    previewImages: [ #imageLiteral(resourceName: "image-dessert-2") ],
//                    title: "Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id elit non mi porta gravida at eget metus.",
//                    subtitle: "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."
//                ),
//                UIGridItem(
//                    previewImages: [ #imageLiteral(resourceName: "image-dessert-3") ],
//                    title: "Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Aenean lacinia bibendum nulla sed consectetur. Cras mattis consectetur purus sit amet fermentum. Cras mattis consectetur purus sit amet fermentum. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
//                    subtitle: "Cras mattis consectetur purus sit amet fermentum."
//                )
//            ]
//        )
        
        
        self.rootComponent = rootComponent
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: rootComponent)
        )
        
    }
    
    public final func activate() { rootComponent.render() }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
