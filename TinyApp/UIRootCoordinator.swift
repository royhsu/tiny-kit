//
//  UIRootCoordinator.swift
//  TinyKitApp
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyCore
import TinyKit
import TinyPost
import TinyStore
import TinyUI

public final class UIRootCoordinator: Coordinator {

    /// The navigator.
    private final let rootViewController: UIViewController
    
    private final var listening: EventEmitter<UIButtonEvent>.Listening?
    
    public init() {
        
        let labelComponentFactory: (String) -> Component = { text in
        
            let label = UILabel()
            
            label.text = text
            
            label.numberOfLines = 0
            
            return UIItemComponent(itemView: label)
        
        }
        
        let imageComponentFactory: (UIImage) -> UIImageComponent = { image in
            
            let imageView = UIImageView()
            
            imageView.contentMode = .scaleAspectFill
            
            imageView.clipsToBounds = true
            
            imageView.image = image
            
            return UIItemComponent<UIImageView>(itemView: imageView)
            
        }

        let buttonComponent = TSPrimaryButtonComponent()
        
        buttonComponent.titleLabel.text = NSLocalizedString(
            "Add to Cart",
            comment: ""
        )
        
        buttonComponent.iconImageView.image = #imageLiteral(resourceName: "icon-plus").withRenderingMode(.alwaysTemplate)
        
        buttonComponent.applyTheme(.current)
        
        listening = buttonComponent.eventEmitter.listen(event: .touchUpInside) { _, event in
            
            print("emitted", event)
            
        }
        
        let reviewSectionHeaderComponent = TSProductSectionHeaderComponent()
        
        reviewSectionHeaderComponent.iconImageView.image = #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
        
        reviewSectionHeaderComponent.titleLabel.text = NSLocalizedString(
            "Reviews",
            comment: ""
        )
        
        reviewSectionHeaderComponent.paddingInsets = UIEdgeInsets(
            top: 8.0,
            left: 16.0,
            bottom: 8.0,
            right: 16.0
        )
        
        let introductionSectionHeaderComponent = TSProductSectionHeaderComponent()
        
        introductionSectionHeaderComponent.iconImageView.image = #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate)
        
        introductionSectionHeaderComponent.titleLabel.text = NSLocalizedString(
            "Introduction",
            comment: ""
        )
        
        introductionSectionHeaderComponent.paddingInsets = UIEdgeInsets(
            top: 8.0,
            left: 16.0,
            bottom: 8.0,
            right: 16.0
        )
        
        let productDetailComponent = TSProductDetailComponent(
            layoutComponent: UIListComponent(
                contentMode: .automatic(estimatedSize: UIScreen.main.bounds.size)
            ),
            descriptionButtonComponent: buttonComponent,
            reviewSectionHeaderComponent: reviewSectionHeaderComponent,
            introductionSectionHeaderComponent: introductionSectionHeaderComponent,
            introductionComponent: TPPostComponent(
                layoutComponent: UIListComponent(
                    contentMode: .automatic(estimatedSize: UIScreen.main.bounds.size)
                )
            )
        )

//        productDetailComponent.galleryComponent.setImageComponents(
//            [
//                imageComponentFactory(#imageLiteral(resourceName: "image-dessert-1")),
//                imageComponentFactory(#imageLiteral(resourceName: "image-dessert-2")),
//                imageComponentFactory(#imageLiteral(resourceName: "image-dessert-3"))
//            ]
//        )
        
        productDetailComponent.galleryComponent.setImageContainers(
            [
                .memory(#imageLiteral(resourceName: "image-dessert-1")),
                .memory(#imageLiteral(resourceName: "image-dessert-2")),
                .memory(#imageLiteral(resourceName: "image-dessert-3"))
            ]
        )

        productDetailComponent.descriptionComponent.titleLabel.text = "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor."

        productDetailComponent.descriptionComponent.subtitleLabel.text = "$12.99"

        productDetailComponent.descriptionComponent.paddingInsets = UIEdgeInsets(
            top: 20.0,
            left: 16.0,
            bottom: 0.0,
            right: 16.0
        )
        
        let reviewComponentFactory: (ImageResource, String, String) -> Component = { pictureImageContainer, title, text in
            
            let reviewComponent = TSProductReviewComponent()
    
            reviewComponent.applyTheme(.current)
            
            reviewComponent.titleLabel.text = title
            
            reviewComponent.textLabel.text = text
            
            reviewComponent.paddingInsets = UIEdgeInsets(
                top: 12.0,
                left: 12.0,
                bottom: 12.0,
                right: 12.0
            )
    
            pictureImageContainer.setImage(to: reviewComponent.pictureImageView)
            
            return reviewComponent
            
        }
        
        productDetailComponent.reviewCarouselComponent.collectionView.contentInset = UIEdgeInsets(
            top: 0.0,
            left: 16.0,
            bottom: 0.0,
            right: 16.0
        )
        
        productDetailComponent.reviewCarouselComponent.layout.interitemSpacing = 16.0
        
        productDetailComponent.reviewCarouselComponent.setItemComponents(
            [
                reviewComponentFactory(
                    .memory(#imageLiteral(resourceName: "image-danielle-schneider")),
                    "Danielle Schneider",
                    "Nullam quis risus eget urna mollis ornare vel eu leo. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec id elit non mi porta gravida at eget metus. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit."
                ),
                reviewComponentFactory(
                    .memory(#imageLiteral(resourceName: "image-jerry-price")),
                    "Jerry Price",
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                ),
                reviewComponentFactory(
                    .memory(#imageLiteral(resourceName: "image-carolyn-simmons")),
                    "Carolyn Simmons",
                    "Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam."
                )
            ]
        )
        
        let paragraphElementFactory: (String) -> ElementComponent = { paragraph in
            
            let paragraphComponent = UIPostParagraphComponent()
            
            paragraphComponent.textLabel.text = "\(paragraph)"
            
            paragraphComponent.paddingInsets = UIEdgeInsets(
                top: 8.0,
                left: 16.0,
                bottom: 8.0,
                right: 16.0
            )
            
            paragraphComponent.applyTheme(.current)
            
            return .paragraph(paragraphComponent)
            
        }
        
        let imageElementFactory: (ImageResource) -> ElementComponent = { container in
            
            let imageComponent = UIPostImageComponent()
            
            imageComponent.applyTheme(.current)
            
            container.setImage(to: imageComponent.imageView)
            
            return .image(imageComponent)
            
        }
        
        productDetailComponent.introductionComponent.setElementComponents(
            [
                imageElementFactory(
                    .memory(#imageLiteral(resourceName: "image-product-story-4"))
                ),
                imageElementFactory(
                    .memory(#imageLiteral(resourceName: "image-product-story-1"))
                ),
                paragraphElementFactory("Cras justo odio, dapibus ac facilisis in, egestas eget quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue."),
                paragraphElementFactory("Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Vestibulum id ligula porta felis euismod semper."),
                imageElementFactory(
                    .memory(#imageLiteral(resourceName: "image-product-story-3"))
                ),
                paragraphElementFactory("Maecenas faucibus mollis interdum. Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Donec ullamcorper nulla non metus auctor fringilla.")
            ]
        )
        
//        let gridComponent = UIGridComponent(
//            layout: UIGridLayout(
//                columns: 2,
//                rows: 2
//            )
//        )
//
//        gridComponent.setItemComponents(
//            [
//                UIItemComponent(itemView: label)
//            ]
//        )
        
        let carouselComponent = UICarouselComponent()
       
        let itemComponents: [Component] = [
            imageComponentFactory(#imageLiteral(resourceName: "image-product-story-4")),
            labelComponentFactory(
                "Maecenas faucibus mollis interdum. Vestibulum id ligula porta felis euismod semper. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla vitae elit libero, a pharetra augue. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Sed posuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            ),
            labelComponentFactory(
                "Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Vestibulum id ligula porta felis euismod semper."
            )
        ]
        
        carouselComponent.numberOfSections = 1
        
        carouselComponent.setItemComponent { _, indexPath in
            
            return itemComponents[indexPath.item]
            
        }
        
        carouselComponent.setNumberOfItemComponents { _, section in
            
            return itemComponents.count
            
        }
        
        let postComponent: TPPostComponent = [
            .image(
                resource: .memory(#imageLiteral(resourceName: "image-product-story-4")),
                factory: { UIPostImageComponent() }
            ),
            .image(
                resource: .memory(#imageLiteral(resourceName: "image-product-story-1")),
                factory: { UIPostImageComponent() }
            ),
            .paragraph(
                text: "Maecenas faucibus mollis interdum. Vestibulum id ligula porta felis euismod semper. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla vitae elit libero, a pharetra augue. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Sed posuere consectetur est at lobortis. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                factory: { UIPostParagraphComponent() }
            ),
            .image(
                resource: .memory(#imageLiteral(resourceName: "image-product-story-3")),
                factory: { UIPostImageComponent() }
            ),
            .paragraph(
                text: "Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Vestibulum id ligula porta felis euismod semper.",
                factory: { UIPostParagraphComponent() }
            )
        ]
        
        let viewController = UIComponentViewController(component: postComponent)

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
