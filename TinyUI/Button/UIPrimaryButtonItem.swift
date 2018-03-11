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
    
    public var backgroundColor: UIColor
    
    public init(
        title: String? = nil,
        titleColor: UIColor = .black,
        backgroundColor: UIColor = .clear
    ) {
        
        self.title = title
        
        self.titleColor = titleColor
        
        self.backgroundColor = backgroundColor
        
    }
    
}
