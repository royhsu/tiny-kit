//
//  UIProductGalleryComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductGalleryComponent

public final class UIProductGalleryComponent: Component {
    
    /// The base component.
    private final let itemComponent: UIItemComponent<UIProductGalleryView>
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(
                UIProductGalleryView.self,
                from: bundle
            )!
        )
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() { itemComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
}

public extension UIProductGalleryComponent {
    
    @discardableResult
    public final func setGallery(_ gallery: UIProductGallery) -> UIProductGalleryComponent {
        
        let galleryView = itemComponent.itemView
        
        if let previewImage = gallery.images.first {
            
            galleryView.imageView.image = previewImage
            
            galleryView.imageView.backgroundColor = .clear
            
        }
        else { galleryView.imageView.backgroundColor = .lightGray }
        
        // NOTE: The added image will cover up the triangle view.
        galleryView.bringSubview(toFront: galleryView.triangleView)
        
        return self
        
    }
    
}
