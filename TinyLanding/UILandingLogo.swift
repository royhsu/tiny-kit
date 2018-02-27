//
//  UILandingLogo.swift
//  TinyLanding
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILandingLogo

public struct UILandingLogo {
    
    public var logoImage: UIImage?
    
    public var backgroundImage: UIImage?
    
    public init(
        logoImage: UIImage? = nil,
        backgroundImage: UIImage? = nil
    ) {
        
        self.logoImage = logoImage
        
        self.backgroundImage = backgroundImage
        
    }
    
}
