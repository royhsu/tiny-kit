//
//  Theme.swift
//  TinyUI
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Theme

public struct Theme {
    
    public let primaryColor: UIColor
    
    public let secondaryColor: UIColor
    
    public let backgroundColor: UIColor
    
    public let titleColor: UIColor
    
    public let subtitleColor: UIColor
    
    public let bodyColor: UIColor
    
    public let placeholderColor: UIColor
    
    public init(
        primaryColor: UIColor,
        secondaryColor: UIColor,
        backgroundColor: UIColor,
        titleColor: UIColor,
        subtitleColor: UIColor,
        bodyColor: UIColor,
        placeholderColor: UIColor
    ) {
        
        self.primaryColor = primaryColor
        
        self.secondaryColor = secondaryColor
        
        self.backgroundColor = backgroundColor
        
        self.titleColor = titleColor
        
        self.subtitleColor = subtitleColor
        
        self.bodyColor = bodyColor
        
        self.placeholderColor = placeholderColor
        
    }
    
}

public extension Theme {
    
    public static var current = {
        
//        return debug
        
        return azureSky
        
    }()
    
}
