//
//  UIProfileIntroduction.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 18/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileIntroduction

import UIKit

public struct UIProfileIntroduction {
    
    public var pictureImage: UIImage?
    
    public var name: String?
    
    public var introduction: String?
    
    public init(
        pictureImage: UIImage? = nil,
        name: String? = nil,
        introduction: String? = nil
    ) {
        
        self.pictureImage = pictureImage
        
        self.name = name
        
        self.introduction = introduction
        
    }
    
}
