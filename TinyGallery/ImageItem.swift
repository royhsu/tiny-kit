//
//  ImageItem.swift
//  TinyGallery
//
//  Created by Roy Hsu on 2018/5/9.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ImageItem

public struct ImageItem {
    
    public let resource: ImageResource
    
    public let factory: () -> ImageComponent
    
    public init(
        resource: ImageResource,
        factory: @escaping () -> ImageComponent
    ) {
        
        self.resource = resource
        
        self.factory = factory
        
    }
    
}
