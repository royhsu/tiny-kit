//
//  UIGalleryComponent.swift
//  TinyStore
//
//  Created by Roy Hsu on 02/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGalleryComponent

public final class UIGalleryComponent: Component {
    
    /// The base component
    private final let carouselComponent: UICarouselComponent
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.carouselComponent = UICarouselComponent(contentMode: contentMode)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return carouselComponent.contentMode }
        
        set { carouselComponent.contentMode = newValue }
        
    }
    
    public final func render() { carouselComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return carouselComponent.view }
    
    public final var preferredContentSize: CGSize { return carouselComponent.preferredContentSize }
    
}

public extension UIGalleryComponent {
    
    @discardableResult
    public final func setImages(
        _ images: [UIImage]
    )
    -> UIGalleryComponent {
        
        let imageComponents: [Component] = images.map { image -> UIItemComponent<UIImageView> in
            
            let imageView = UIImageView(image: image)
            
            imageView.contentMode = .scaleAspectFill
            
            imageView.clipsToBounds = true
            
            return UIItemComponent(itemView: imageView)
            
        }
        
        carouselComponent.itemComponents = AnyCollection(imageComponents)
        
        return self
        
    }
    
}
