//
//  UIProductDetailComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 14/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductDetailComponent

import TinyPost

public final class UIProductDetailComponent: Component {
    
    /// The base component
    private final let listComponent: UIListComponent
    
    private final let detailHeaderComponent: UIProductDetailHeaderComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.detailHeaderComponent = UIProductDetailHeaderComponent()
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        listComponent.headerComponent = detailHeaderComponent
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

import TinyUI

public extension UIProductDetailComponent {
    
    @discardableResult
    public final func setGallery(_ gallery: UIProductGallery) -> UIProductDetailComponent {
        
        detailHeaderComponent.setGallery(gallery)
        
        return self
        
    }
    
    @discardableResult
    public final func setDescription(_ description: UIProductDescription) -> UIProductDetailComponent {
        
        detailHeaderComponent.setDescription(description)
        
        return self
        
    }
    
//    @discardableResult
//    public final func setActionButtonItem(_ item: UIPrimaryButtonItem) -> UIProductDetailComponent {
//        
//        detailHeaderComponent.setActionButtonItem(item)
//        
//        return self
//        
//    }
    
    @discardableResult
    public final func setReviews(
        _ reviews: [UIProductReview]
    )
    -> UIProductDetailComponent {
        
        detailHeaderComponent.setReviews(reviews)
        
        return self
        
    }
    
//    @discardableResult
//    public final func setPost(
//        elements: [UIPostElement]
//    )
//    -> UIProductDetailComponent {
//
//        // Insert spacings between elements.
//        let defaultSpacing: CGFloat = 20.0
//
//        let spacingComponent: (CGFloat) -> Component = { spacing in
//
//            return UIItemComponent(
//                contentMode: .size(
//                    width: spacing,
//                    height: spacing
//                ),
//                itemView: UIView()
//            )
//
//        }
//
//        let spacedElementComponents = elementComponents
//            .map { [ $0 ] }
//            .joined(
//                separator: [ spacingComponent(defaultSpacing) ]
//            )
//            .flatMap { $0 }
//
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
    
    public typealias ActionHandler = () -> Void
    
    @discardableResult
    public final func setAction(_ handler: ActionHandler?) -> UIProductDetailComponent {
        
        detailHeaderComponent.setAction(handler)
        
        return self
        
    }
    
}
