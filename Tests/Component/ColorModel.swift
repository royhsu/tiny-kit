//
//  ColorComponentModel.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Color

import UIKit

internal struct Color: Codable {
    
    internal let red: CGFloat
    
    internal let green: CGFloat
    
    internal let blue: CGFloat
    
    internal let alpha: CGFloat
    
}

// MARK: - UIColor

internal extension Color {
    
    internal func uiColor() -> UIColor {
        
        return UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: alpha
        )
        
    }
    
}
