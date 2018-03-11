//
//  UIProductComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 01/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductComponent

public final class UIProductComponent: Component {
    
    private final let listComponent: UIListComponent
    
    private final let galleryComponent: UIGalleryComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.listComponent = UIListComponent(contentMode: contentMode)
        
        self.galleryComponent = UIGalleryComponent()
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return listComponent.contentMode }
        
        set { listComponent.contentMode = newValue }
    
    }
    
    public final func render() {
        
        let width = listComponent.view.bounds.width
        
        galleryComponent.contentMode = .size(
            width: width,
            height: width
        )
        
        listComponent.itemComponents = AnyCollection(
            [ galleryComponent ]
        )
        
        listComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return listComponent.view }
    
    public final var preferredContentSize: CGSize { return listComponent.preferredContentSize }
    
}

public extension UIProductComponent {
    
    @discardableResult
    public final func setImages(
        _ images: [UIImage]
    )
    -> UIProductComponent {
        
        galleryComponent.setImages(images)
        
        return self
        
    }
    
}
