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
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

// MARK: - UIProductDetailHeaderComponent

public final class UIProductDetailHeaderComponent: Component {
    
    /// The base component.
    private final let listComponent: UIListComponent
    
    private final let galleryComponent: UIProductGalleryComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.galleryComponent = UIProductGalleryComponent()
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let width = view.bounds.width
        
        let height = width / (16.0 / 9.0)
        
        galleryComponent.contentMode = .size(
            width: width,
            height: height
        )
        
        listComponent.itemComponents = AnyCollection(
            [
                galleryComponent
            ]
        )
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

public extension UIProductDetailHeaderComponent {
    
    public final func setGallery(_ gallery: UIProductGallery) -> UIProductDetailHeaderComponent {
        
        galleryComponent.setGallery(gallery)
        
        return self
        
    }
    
}
