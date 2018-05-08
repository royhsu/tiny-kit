//
//  SlideComponent.swift
//  TinySlide
//
//  Created by Roy Hsu on 2018/5/4.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SlideComponent

// TODO: This component is almost identical to the collection component. It seems like it loses its weight.
// The problem is to find a correct way to make a view from a model that isn't the anti-pattern.
public protocol SlideComponent: Component {
    
    var numberOfElementComponents: Int { get set }
    
    func elementComponent(at index: Int) -> ElementComponent
    
    typealias ElementComponentProvider = (
        _ component: Component,
        _ index: Int
    )
    -> ElementComponent
    
    func setElementComponent(provider: @escaping ElementComponentProvider)
    
}

public extension SlideComponent {
    
    public func setElementsComponents(
        _ components: [ElementComponent]
    ) {
        
        numberOfElementComponents = components.count
        
        setElementComponent { _, index in components[index] }
        
    }
    
}

public extension SlideComponent {
    
    public typealias ElementProvider = (
        _ component: Component,
        _ index: Int
    )
    -> Element
    
    public func setElement(provider: @escaping ElementProvider) {
        
        setElementComponent { component, index in
            
            let element = provider(
                component,
                index
            )
            
            switch element {
                
            case let .image(
                resource,
                factory
            ):
                
                let imageComponent = factory()
                
                imageComponent.setImageResource(resource)
                
                return .image(imageComponent)
                
            }
            
        }
        
    }
    
    public func setElements(
        _ elements: [Element]
    ) {
        
        numberOfElementComponents = elements.count
        
        setElement { _, index in elements[index] }
        
    }
    
}
