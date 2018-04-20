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

        let buttonComponent = TSPrimaryButtonComponent()
        
        buttonComponent.titleLabel.text = NSLocalizedString(
            "Add to Cart",
            comment: ""
        )
        
        buttonComponent.iconImageView.image = #imageLiteral(resourceName: "icon-plus").withRenderingMode(.alwaysTemplate)
        
        buttonComponent.applyTheme(.current)
        
        listening = buttonComponent.eventEmitter.listen(event: .touchUpInside) { event in
            
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
            top: 20.0,
            left: 16.0,
            bottom: 0.0,
            right: 16.0
        )
        
        let reviewPaddingInsets = UIEdgeInsets(
            top: 12.0,
            left: 12.0,
            bottom: 12.0,
            right: 12.0
        )
        
        let review1Component = TSProductReviewComponent()
        
        review1Component.pictureImageView.image = #imageLiteral(resourceName: "image-danielle-schneider")
        
        review1Component.applyTheme(.current)
        
        review1Component.titleLabel.text = "Danielle Schneider"
        
        review1Component.textLabel.text = "Nullam quis risus eget urna mollis ornare vel eu leo. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Donec id elit non mi porta gravida at eget metus. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit."
        
//        review1Component.paddingInsets = reviewPaddingInsets

        let review2Component = TSProductReviewComponent()
        
        review2Component.applyTheme(.current)
        
        review2Component.pictureImageView.image = #imageLiteral(resourceName: "image-jerry-price")
        
        review2Component.titleLabel.text = "Jerry Price"
        
        review2Component.textLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        
//        review2Component.paddingInsets = reviewPaddingInsets
        
        let review3Component = TSProductReviewComponent()
        
        review3Component.applyTheme(.current)
        
        review3Component.pictureImageView.image = #imageLiteral(resourceName: "image-carolyn-simmons")
        
        review3Component.titleLabel.text = "Carolyn Simmons"
        
        review3Component.textLabel.text = "Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam."
        
//        review3Component.paddingInsets = reviewPaddingInsets
        
        productDetailComponent.reviewCarouselComponent.collectionView.contentInset = UIEdgeInsets(
            top: 0.0,
            left: 16.0,
            bottom: 8.0,
            right: 16.0
        )
        
        productDetailComponent.reviewCarouselComponent.layout.interitemSpacing = 16.0
        
        productDetailComponent.reviewCarouselComponent.setItemComponents(
            [
                review1Component,
                review2Component,
                review3Component
            ]
        )
        
        let paragraphElementFactory: (String) -> Element = { paragraph in
            
            let paragraphComponent = TPPostParagraphComponent()
            
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
        
        let imageElementFactory: (ImageContainer) -> Element = { container in
            
            let imageComponent = TPPostImageComponent()
            
            imageComponent.applyTheme(.current)
            
            container.setImage(to: imageComponent.imageView)
            
            return .image(imageComponent)
            
        }
        
        let postComponent = TPPostComponent(
            layoutComponent: UIListComponent()
        )
        
        postComponent.setElements(
            [
                imageElementFactory(
                    .image(#imageLiteral(resourceName: "image-product-story-4"))
                ),
                imageElementFactory(
                    .image(#imageLiteral(resourceName: "image-product-story-1"))
                ),
                paragraphElementFactory("Cras justo odio, dapibus ac facilisis in, egestas eget quam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue."),
                paragraphElementFactory("Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Vestibulum id ligula porta felis euismod semper."),
                imageElementFactory(
                    .image(#imageLiteral(resourceName: "image-product-story-3"))
                ),
                paragraphElementFactory("Maecenas faucibus mollis interdum. Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Donec ullamcorper nulla non metus auctor fringilla.")
            ]
        )
        
        let carouselComponent = UICarouselComponent(
            contentMode: .size(
                CGSize(
                    width: 167.0,
                    height: 167.0
                )
            )
        )
        
        let r1 = UIItemComponent<TSProductReviewView>(
            itemView: UIView.load(
                TSProductReviewView.self,
                from: Bundle(for: TSProductReviewView.self)
            )!
        )
        
        r1.itemView.textLabel.text = "Donec sed odio dui. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Maecenas sed diam eget risus varius blandit sit amet non magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        
        r1.itemView.titleLabel.text = "Etiam porta sem malesuada magna mollis euismod. Sed posuere consectetur est at lobortis."
        
        r1.itemView.pictureImageView.image = #imageLiteral(resourceName: "image-jerry-price")
        
        let r2 = UIItemComponent<TSProductReviewView>(
            itemView: UIView.load(
                TSProductReviewView.self,
                from: Bundle(for: TSProductReviewView.self)
            )!
        )
        
        r2.itemView.textLabel.text = "Donec sed odio dui. Vestibulum id ligula porta felis euismod semper. Cras mattis consectetur purus sit amet fermentum. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Maecenas sed diam eget risus varius blandit sit amet non magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        
        r2.itemView.titleLabel.text = "Etiam porta sem malesuada magna mollis euismod. Sed posuere consectetur est at lobortis."
        
        r2.itemView.pictureImageView.image = #imageLiteral(resourceName: "image-carolyn-simmons")
        
        let r3 = UIItemComponent<TSProductReviewView>(
            itemView: UIView.load(
                TSProductReviewView.self,
                from: Bundle(for: TSProductReviewView.self)
            )!
        )
        
        r3.itemView.textLabel.text = "Cras justo odio, dapibus ac facilisis in, egestas eget quam. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui."
        
        r3.itemView.titleLabel.text = "Etiam porta sem malesuada magna mollis euismod. Sed posuere consectetur est at lobortis."
        
        r3.itemView.pictureImageView.image = #imageLiteral(resourceName: "image-danielle-schneider")
        
//        carouselComponent.setItemComponents(
//            [
//                r1,
//                r2
//                review1Component,
//                review2Component,
//                review3Component
//            ]
//        )
        
//        let list2Component = UIListComponent()
        
//        list2Component.setItemComponents(
//            [ carouselComponent ]
//        )
        
        let gridComponent = UIGridComponent(
            layout: UIGridLayout(
                columns: 2,
                rows: 2
            )
        )
        
        gridComponent.setItemComponents(
            [
                r1,
                r2,
                r3
            ]
        )
        
        let viewController = UIComponentViewController(component: gridComponent)

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
