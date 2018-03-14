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
    
    private final let galleryAspectRatio: CGFloat = (16.0 / 9.0)
    
    private final let descriptionComponent: UIProductDescriptionComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.galleryComponent = UIProductGalleryComponent()
        
        self.descriptionComponent = UIProductDescriptionComponent()
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let galleryWidth = view.bounds.width
        
        let galleryHeight = (galleryWidth / galleryAspectRatio)
        
        galleryComponent.contentMode = .size(
            width: galleryWidth,
            height: galleryHeight
        )
        
        listComponent.itemComponents = AnyCollection(
            [
                galleryComponent,
                makeSpacingComponent(spacing: 20.0),
                descriptionComponent
            ]
        )
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
    // MARK: Spacing
    
    fileprivate final func makeSpacingComponent(spacing: CGFloat) -> UIItemComponent<UIView> {
        
        let spacingComponent = UIItemComponent(
            contentMode: .size(
                width: spacing,
                height: spacing
            ),
            itemView: UIView()
        )
        
        return spacingComponent
        
    }
    
}

public extension UIProductDetailHeaderComponent {
    
    @discardableResult
    public final func setGallery(_ gallery: UIProductGallery) -> UIProductDetailHeaderComponent {
        
        galleryComponent.setGallery(gallery)
        
        return self
        
    }
    
    @discardableResult
    public final func setDescription(_ description: UIProductDescription) -> UIProductDetailHeaderComponent {
        
        descriptionComponent.setDescription(description)
        
        return self
        
    }
    
}
