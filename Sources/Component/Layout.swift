//
//  Layout.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/27.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentRepresentable

public protocol ComponentRepresentable {
    
    var component: Component { get }
    
}

// MARK: - Layout

public enum Layout<Item> where Item: ComponentRepresentable {
    
    case list(
        name: String,
        items: [Item],
        factory: () -> ListComponent
    )
    
    case carousel(
        name: String,
        items: [Item],
        factory: () -> UICarouselComponent
    )
    
    case custom(
        name: String,
        item: Item
    )
    
}

extension Layout: ComponentRepresentable {
    
    public var component: Component {
        
        switch self {
            
        case let .list(
            name,
            items,
            factory
        ):
            
            let listComponent = factory()
            
            listComponent.setItemComponents(
                items.map { $0.component }
            )
                
            return listComponent
            
        case let .carousel(
            name,
            items,
            factory
        ):
            
            let carouselComponent = factory()
            
            carouselComponent.setItemComponents(
                items.map { $0.component }
            )
            
            return carouselComponent
            
        case let .custom(
            name,
            item
        ): return item.component
            
        }
        
    }
    
}
