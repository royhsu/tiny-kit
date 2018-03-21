//
//  UIProductReview.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductReview

public struct UIProductReview {
    
    public var pictureImage: UIImage?
    
    public var title: String?
    
    public var text: String?
    
    public init(
        pictureImage: UIImage? = nil,
        title: String? = nil,
        text: String? = nil
    ) {
        
        self.pictureImage = pictureImage
        
        self.title = title
        
        self.text = text
        
    }
    
}
