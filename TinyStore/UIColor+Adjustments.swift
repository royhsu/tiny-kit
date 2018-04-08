//
//  UIColor+Adjustments.swift
//  TinyStore
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//


public extension UIColor {
    
    public final func modifiedWithAdditionalHue(
        _ hue: CGFloat,
        saturation: CGFloat,
        brightness: CGFloat
    )
    -> UIColor {
            
        var currentHue: CGFloat = 0.0
        
        var currentSaturation: CGFloat = 0.0
        
        var currentBrigthness: CGFloat = 0.0
        
        var currentAlpha: CGFloat = 0.0
        
        if getHue(
            &currentHue,
            saturation: &currentSaturation,
            brightness: &currentBrigthness,
            alpha: &currentAlpha
        ) {
            
            return UIColor(
                hue: currentHue + hue,
                saturation: currentSaturation + saturation,
                brightness: currentBrigthness + brightness,
                alpha: currentAlpha
            )
            
        }
        
        return self
            
    }
    
}
