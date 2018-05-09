//
//  GalleryComponent.swift
//  TinyGallery
//
//  Created by Roy Hsu on 2018/5/9.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - GalleryComponent

public protocol GalleryComponent: Component {
    
    var numberOfImageComponents: Int { get set }
    
    func imageComponent(at index: Int) -> ImageComponent
    
    typealias ImageComponentProvider = (
        _ component: Component,
        _ index: Int
    )
    -> ImageComponent
    
    func setImageComponent(provider: @escaping ImageComponentProvider)
    
}

public extension GalleryComponent {
    
    public typealias ImageItemProvider = (
        _ component: Component,
        _ index: Int
    )
    -> ImageItem
    
    public func setImageItem(provider: @escaping ImageItemProvider) {
        
        setImageComponent { component, index in
            
            let item = provider(
                component,
                index
            )
            
            let imageComponent = item.factory()
            
            imageComponent.setImageResource(item.resource)
            
            return imageComponent
            
        }
        
    }
    
    public func setImageItems(
        _ items: [ImageItem]
    ) {
    
        numberOfImageComponents = items.count
        
        setImageItem { _, index in items[index] }
        
    }
    
}
