//
//  Element.swift
//  TinySlide
//
//  Created by Roy Hsu on 2018/5/4.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Element

public enum Element {
    
    case image(
        resource: ImageResource,
        factory: () -> ImageComponent
    )
    
}

