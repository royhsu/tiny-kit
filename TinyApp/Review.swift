//
//  Review.swift
//  TinyApp
//
//  Created by Roy Hsu on 23/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Review

public struct Review {
    
    public let imageProcessing: ImageProcessing?
    
    public let title: String?
    
    public let text: String?
    
    public init(
        imageProcessing: ImageProcessing? = nil,
        title: String? = nil,
        text: String? = nil
    ) {
        
        self.imageProcessing = imageProcessing
        
        self.title = title
        
        self.text = text
        
    }
    
}
