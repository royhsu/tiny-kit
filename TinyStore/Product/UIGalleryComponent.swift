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
    
    private final var images: [UIImage] = []
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        self.carouselComponent = UICarouselComponent(contentMode: contentMode)
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return carouselComponent.contentMode }
        
        set { carouselComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        carouselComponent.render()
        
        for index in 0..<images.count {
            
            let imageComponent = self.carouselComponent.itemComponents[AnyIndex(index)] as? UIItemComponent<UIGalleryImageView>
            
            imageComponent?.itemView.imageView.image = self.images[index]
            
        }
        
    }
    
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
        
        self.images = images
        
        let imageComponents: [Component] = images.map { image -> UIItemComponent<UIGalleryImageView> in
            
            let bundle = Bundle(
                for: type(of: self)
            )
            
            let component = UIItemComponent(
                itemView: UIView.load(
                    UIGalleryImageView.self,
                    from: bundle
                )!
            )
            
//            component.itemView.imageView.image = image
            
            return component
            
        }
        
        carouselComponent.itemComponents = AnyCollection(imageComponents)
        
        return self
        
    }
    
}
