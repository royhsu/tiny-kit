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

    public init(contentMode: ComponentContentMode = .automatic) {

        self.carouselComponent = UICarouselComponent(contentMode: contentMode)

        self.numberOfImages = 0

        self.prepare()

    }
    
    public final var numberOfImages: Int
    
    public typealias ImageContainerProvider = (_ index: Int) -> ImageContainer
    
    private final var imageContainerProvider: ImageContainerProvider?
    
    public final func setImageContainer(provider: @escaping ImageContainerProvider) { imageContainerProvider = provider }
    
    // MARK: Set Up

    fileprivate final func prepare() {
        
        carouselComponent.collectionView.isPagingEnabled = true
        
        carouselComponent.collectionView.clipsToBounds = true
        
        carouselComponent.numberOfSections = 1
        
        carouselComponent.setNumberOfItemComponents { [unowned self] _ in self.numberOfImages }
        
        carouselComponent.setItemComponent { [unowned self] indexPath in

            let imageView = UIImageView()

            imageView.contentMode = .scaleAspectFill

            imageView.clipsToBounds = true

            let itemComponent = UIItemComponent(itemView: imageView)

            let imageContainer = self.imageContainerProvider?(indexPath.item)

            imageContainer?.setImage(to: imageView)

            return itemComponent

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
    
    public final func setImageContainers(
        _ containers: [ImageContainer]
    ) {
        
        numberOfImages = containers.count
        
        setImageContainer { index in containers[index] }
        
    }
    
}
