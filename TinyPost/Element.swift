//
//  Element.swift
//  TinyPost
//
//  Created by Roy Hsu on 2018/4/24.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Element

public enum Element {
    
    case paragraph(
        text: String,
        factory: () -> ParagraphComponent
    )
    
    case image(
        resource: ImageResource,
        factory: () -> ImageComponent
    )
    
}

// MARK: - ComponentRepresentable

extension Element: ComponentRepresentable {
    
    public var component: Component {
        
        switch self {
            
        case let .paragraph(
            text,
            factory
        ):
            
            let paragraphComponent = factory()
            
            paragraphComponent.text = text
            
            return paragraphComponent
            
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
            
            return imageComponent
            
        }
        
    }
    
}
