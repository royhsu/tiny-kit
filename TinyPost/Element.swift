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
