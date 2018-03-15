//
//  UICarouselComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICarouselComponent

/// All items in a carousel component will be stretch out to fit the height of it.
public final class UICarouselComponent: Component {
    
    /// The base component.
    private final let collectionComponent: UICollectionComponent

    public final var itemComponents: AnyCollection<Component> = AnyCollection(
        []
    )
    
    public init(contentMode: ComponentContentMode = .automatic) {
        
        let collectionComponent = UICollectionComponent(contentMode: contentMode)
        
        collectionComponent.scrollDirection = .horizontal
        
        self.collectionComponent = collectionComponent
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return collectionComponent.contentMode }
        
        set { collectionComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
//        let components = itemComponents.map { component -> Component in
//
//            component.render()
//
//            var itemComponent = component
//
//            itemComponent.contentMode = .size(
//                width: component.view.bounds.width,
//                height: view.bounds.height
//            )
//
//            return itemComponent
//
//        }
//
//        itemComponents = AnyCollection(components)
        
        collectionComponent.itemComponents = itemComponents
        
        collectionComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return collectionComponent.view }
    
    public final var preferredContentSize: CGSize { return collectionComponent.preferredContentSize }
    
}
