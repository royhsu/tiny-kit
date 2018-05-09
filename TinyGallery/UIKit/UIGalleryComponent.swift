//
//  UIGalleryComponent.swift
//  TinyGallery
//
//  Created by Roy Hsu on 2018/5/9.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGalleryComponent

public final class UIGalleryComponent: GalleryComponent {
    
    /// The base component.
    private final let carouselComponent: UICarouselComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
        ) {
        
        self.carouselComponent = UICarouselComponent(contentMode: contentMode)
        
        self.numberOfImageComponents = 0
        
        self.prepare()
        
    }
    
    // MARK: GalleryComponent
    
    public final var numberOfImageComponents: Int
    
    public final func imageComponent(at index: Int) -> ImageComponent {
        
        guard
            let provider = imageComponentProvider
            else { fatalError("Please make sure to set the provider with setImageComponent(provider:) firstly.") }
        
        return provider(
            self,
            index
        )
        
    }
    
    private final var imageComponentProvider: ImageComponentProvider?
    
    public final func setImageComponent(provider: @escaping ImageComponentProvider) { imageComponentProvider = provider }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        carouselComponent.collectionView.isPagingEnabled = true
        
        carouselComponent.collectionView.clipsToBounds = true
        
        carouselComponent.numberOfSections = 1
        
        carouselComponent.setNumberOfItemComponents { [unowned self] _, _ in self.numberOfImageComponents }
        
        carouselComponent.setItemComponent { [unowned self] _, indexPath in  self.imageComponent(at: indexPath.item) }
        
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
