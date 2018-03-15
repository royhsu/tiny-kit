//
//  UIPrimaryButtonItem.swift
//  TinyUI
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPrimaryButtonItem

public struct UIPrimaryButtonItem {
    
    public var title: String?
    
    public var titleColor: UIColor
    
    public var iconImage: UIImage?
    
    public var backgroundColor: UIColor
    
    public init(
        title: String? = nil,
        titleColor: UIColor = .black,
        iconImage: UIImage? = nil,
        backgroundColor: UIColor = .lightGray
    ) {
        
        self.title = title
        
        self.titleColor = titleColor
        
        self.iconImage = iconImage
        
        self.backgroundColor = backgroundColor
        
    }
    
}
