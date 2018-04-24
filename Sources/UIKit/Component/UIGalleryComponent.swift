//
//  UIGalleryComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGalleryComponent

public final class UIGalleryComponent: Component {

    /// The base component.
    private final let carouselComponent: UICarouselComponent

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.carouselComponent = UICarouselComponent(contentMode: contentMode)

        self.numberOfImageComponents = 0

        self.prepare()

    }
    
    public final var numberOfImageComponents: Int
    
    public final func imageComponent(at index: Int) -> UIImageComponent {
        
        guard
            let provider = imageComponentProvider
        else { fatalError("Please make sure to set the provider with setImageComponent(provider:) firstly.") }
        
        return provider(
            self,
            index
        )
        
    }
    
    public typealias ImageComponentProvider = (
        _ component: Component,
        _ index: Int
    )
    -> UIImageComponent
    
    private final var imageComponentProvider: ImageComponentProvider?
    
    public final func setImageComponent(provider: @escaping ImageComponentProvider) { imageComponentProvider = provider }
    
    // MARK: Set Up

    fileprivate final func prepare() {
        
        carouselComponent.collectionView.isPagingEnabled = true

        carouselComponent.collectionView.clipsToBounds = true

        carouselComponent.numberOfSections = 1

        carouselComponent.setNumberOfItemComponents { [unowned self] _, _ in self.numberOfImageComponents }

        carouselComponent.setItemComponent { [unowned self] _, indexPath in

            return self.imageComponent(at: indexPath.item)

        }

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
    
    public final func setImageComponents(
        _ components: [UIImageComponent]
    ) {
        
        numberOfImageComponents = components.count
        
        setImageComponent { _, index in components[index] }
        
    }
    
    public typealias ImageContainerProvider = (
        _ component: Component,
        _ index: Int
    )
    -> UIImageContainer
    
    public final func setImageContainer(provider: @escaping ImageContainerProvider) {
        
        setImageComponent { component, index in
            
            let imageView = UIImageView()
            
            imageView.contentMode = .scaleAspectFill
            
            imageView.clipsToBounds = true
            
            let imageComponent = UIItemComponent(itemView: imageView)
            
            let imageContainer = provider(
                component,
                index
            )
            
            imageContainer.setImage(to: imageView)
            
            return imageComponent
            
        }
        
    }
    
    public final func setImageContainers(
        _ containers: [UIImageContainer]
    ) {
        
        numberOfImageComponents = containers.count
        
        setImageContainer { _, index in containers[index] }
        
    }
    
}
