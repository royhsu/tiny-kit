//
//  UICartItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartItem

public struct UICartItem {
    
    public var previewImage: UIImage?
    
    public var title: String?
    
    public var price: Double?
    
    public init(
        previewImage: UIImage? = nil,
        title: String? = nil,
        price: Double? = nil
    ) {
        
        self.previewImage = previewImage
        
        self.title = title
        
        self.price = price
        
    }
    
}
