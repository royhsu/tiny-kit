//
//  UIView+ColorShadow.swift
//  ShadowView
//
//  Created by Pierre Perrin on 25/07/2017.
//  Copyright © 2017 Pierreperrin. All rights reserved.
//

import UIKit

extension UIView{
    
    ///Returns a UIImage copy of the view
    internal func copyAsImage(completion: @escaping (UIImage) -> Void) {
        
        DispatchQueue.main.async {
            
            let layer = self.layer
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                let size = layer.frame.size
                
                let image = layer.image(ofSize: size)
                
                completion(image)
                
            }
            
        }
        
    }
    
}

extension CALayer {
    
    func image(ofSize size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        guard
            let currentContext = UIGraphicsGetCurrentContext()
        else { return UIImage() }
        
        render(in: currentContext)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        guard
            let cgImage = image?.cgImage
        else { return UIImage() }
        
        return UIImage(cgImage: cgImage)
        
    }
    
}
