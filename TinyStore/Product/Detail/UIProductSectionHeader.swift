//
//  UIProductSectionHeader.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductSectionHeader

public struct UIProductSectionHeader {
    
    public var iconImage: UIImage?
    
    public var title: String?
    
    public init(
        iconImage: UIImage? = nil,
        title: String? = nil
    ) {
        
        self.iconImage = iconImage
        
        self.title = title
        
    }
    
}
