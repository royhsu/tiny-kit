//
//  PostComponent.swift
//  TinyPost
//
//  Created by Roy Hsu on 2018/4/15.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostComponent

public protocol PostComponent: Component {
    
    var numberOfElementComponents: Int { get set }
    
    func elementComponent(at index: Int) -> ElementComponent
    
    typealias ElementComponentProvider = (
        _ component: PostComponent,
        _ index: Int
    )
    -> ElementComponent
    
    func setElementComponent(provider: @escaping ElementComponentProvider)
    
}

public extension PostComponent {
    
    public func setElementComponents(
        _ components: [ElementComponent]
    ) {
        
        numberOfElementComponents = components.count
        
        setElementComponent { _, index in components[index] }
        
    }
    
}

public extension PostComponent {
    
    public typealias ElementProvider = (
        _ component: PostComponent,
        _ index: Int
    )
    -> Element
    
    public func setElement(
        provider: @escaping ElementProvider
    ) {
        
        setElementComponent { component, index in
            
            let element = provider(
                component,
                index
            )
            
            switch element {
                
            case let .paragraph(
                text,
                factory
            ):
                
                let paragraphComponent = factory()
                
                paragraphComponent.text = text
                
                return .paragraph(paragraphComponent)
                
            case let .image(
                resource,
                factory
            ):
                
                let imageComponent = factory()
                
                switch resource {
                    
                case let .memory(image): imageComponent.image = image
                   
                case let .remote(url, provider, context):
                    
                    provider.fetch(
                        in: context,
                        url: url
                    )
                    .then(in: .main) { image in imageComponent.image = image }
                    
                }
                
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
