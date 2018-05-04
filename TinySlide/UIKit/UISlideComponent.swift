//
//  UISlideComponent.swift
//  TinySlide
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISlideComponent

public final class UISlideComponent: SlideComponent {

    /// The base component.
    private final let carouselComponent: UICarouselComponent

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.carouselComponent = UICarouselComponent(contentMode: contentMode)

        self.numberOfElementComponents = 0

        self.prepare()

    }
    
    // MARK: SlideComponent
    
    public final var numberOfElementComponents: Int
    
    public final func elementComponent(at index: Int) -> ElementComponent {
        
        guard
            let provider = elementComponentProvider
        else { fatalError("Please make sure to set the provider with setElementComponent(provider:) firstly.") }
        
        return provider(
            self,
            index
        )
        
    }
    
    private final var elementComponentProvider: ElementComponentProvider?
    
    public final func setElementComponent(provider: @escaping ElementComponentProvider) { elementComponentProvider = provider }
    
    // MARK: Set Up

    fileprivate final func prepare() {
        
        carouselComponent.collectionView.isPagingEnabled = true

        carouselComponent.collectionView.clipsToBounds = true

        carouselComponent.numberOfSections = 1

        carouselComponent.setNumberOfItemComponents { [unowned self] _, _ in self.numberOfElementComponents }

        carouselComponent.setItemComponent { [unowned self] _, indexPath in

            switch self.elementComponent(at: indexPath.item)  {
                
            case let .image(component): return component
                
            }

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
