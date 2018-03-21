//
//  UIProductDetailComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDetailComponent

import TinyPost
import TinyUI

public final class UIProductDetailComponent: Component {
    
    /// The base component
    private final let listComponent: UINewListComponent
    
    private final let actionButtonComponent: UIPrimaryButtonComponent
    
    private final let detailHeaderComponent: UIProductDetailHeaderComponent
    
    private final let postComponent: UIPostComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UINewListComponent(contentMode: contentMode)
        
        self.actionButtonComponent = UIPrimaryButtonComponent()
        
        self.detailHeaderComponent = UIProductDetailHeaderComponent(actionButtonComponent: actionButtonComponent)
        
        self.postComponent = UIPostComponent()
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        listComponent
            .setHeaderComponent(detailHeaderComponent)
            .setNumberOfSections { 1 }
            .setNumberOfItems { _ in self.postComponent.elementComponents.count }
            .setComponentForItem { self.postComponent.elementComponents[$0.item] }
        
        actionButtonComponent
            .setTitle("Add to Cart")
            .setAction { print("Add to the cart.") }
        
        detailHeaderComponent.galleryComponent.setImages(
            [ #imageLiteral(resourceName: "image-dessert-1") ]
        )
        
        detailHeaderComponent.descriptionComponent
            .setTitle(
                "Donec id elit non mi porta gravida at eget metus. Sed posuere consectetur est at lobortis. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Sed posuere consectetur est at lobortis."
        
            )
            .setSubtitle("Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla.")
        
        detailHeaderComponent.reviewCarouselComponent.setReviews(
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
                ),
                UIProductReview(
                    pictureImage: #imageLiteral(resourceName: "image-danielle-schneider"),
                    title: "Danielle Schneider",
                    content: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor."
                )
            ]
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() { listComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

import TinyUI

public extension UIProductDetailComponent {
    
//    @discardableResult
//    public final func setGallery(_ gallery: UIProductGallery) -> UIProductDetailComponent {
//
//        detailHeaderComponent.setGallery(gallery)
//
//        return self
//
//    }
//
//    @discardableResult
//    public final func setDescription(_ description: UIProductDescription) -> UIProductDetailComponent {
//
//        detailHeaderComponent.setDescription(description)
//
//        return self
//
//    }
    
//    @discardableResult
//    public final func setActionButtonItem(_ item: UIPrimaryButtonItem) -> UIProductDetailComponent {
//        
//        detailHeaderComponent.setActionButtonItem(item)
//        
//        return self
//        
//    }
    
//    @discardableResult
//    public final func setReviews(
//        _ reviews: [UIProductReview]
//    )
//    -> UIProductDetailComponent {
//
//        detailHeaderComponent.setReviews(reviews)
//
//        return self
//
//    }
    
    @discardableResult
    public final func setPost(
        elements: [PostElement]
    )
    -> UIProductDetailComponent {
        
        postComponent.setPost(elements: elements)
     
        return self
        
    }
    
//        var components: [Component] = [
//            spacingComponent(defaultSpacing),
//            UIProductSectionHeaderComponent().setHeader(
//                UIProductSectionHeader(
//                    iconImage: #imageLiteral(resourceName: "icon-digest").withRenderingMode(.alwaysTemplate),
//                    title: "Story"
//                )
//            ),
//            spacingComponent(defaultSpacing)
//        ]
//
//        components.append(contentsOf: spacedElementComponents)
//
//        listComponent.itemComponents = AnyCollection(components)
//
//        return self
//
//    }
    
//    public typealias ActionHandler = () -> Void
//
//    @discardableResult
//    public final func setAction(_ handler: ActionHandler?) -> UIProductDetailComponent {
//
//        detailHeaderComponent.setAction(handler)
//
//        return self
//
//    }
    
}
