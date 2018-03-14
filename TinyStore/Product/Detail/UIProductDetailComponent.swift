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
    
    @discardableResult
    public final func setReviews(
        _ reviews: [UIProductReview]
    )
    -> UIProductDetailComponent {
        
        detailHeaderComponent.setReviews(reviews)
        
        return self
        
    }
    
}
