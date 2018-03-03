//
//  UICarouselComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICarouselComponent

public final class UICarouselComponent: Component {
    
    /// The base component.
    private final let collectionComponent: UICollectionComponent
    
    public final var itemComponents: ComponentGroup {
        
        get { return collectionComponent.itemComponents }
        
        set { collectionComponent.itemComponents = newValue }
        
    }
    
    public init(
        contentMode: ComponentContentMode = .automatic
    ) {
        
        let collectionComponent = UICollectionComponent(contentMode: contentMode)
        
        collectionComponent.scrollDirection = .horizontal
        
        self.collectionComponent = collectionComponent
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return collectionComponent.contentMode }
        
        set { collectionComponent.contentMode = newValue }
        
    }
    
    public final func render() { collectionComponent.render() }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionComponent.view }
    
    public final var preferredContentSize: CGSize { return collectionComponent.preferredContentSize }
    
}
