//
//  ShadowView+BlurProcess.swift
//  ShadowView
//
//  Created by Pierre Perrin on 26/07/2017.
//  Copyright © 2017 Pierreperrin. All rights reserved.
//

import UIKit

public extension ShadowView {
    
    public func updateShadow() {
        
        copyAsImage { [weak self] image in
            
            guard
                let weakSelf = self
            else { return }
        
            let containerLayer = CALayer()
            
            let imageSize = image.size
            
            containerLayer.frame = CGRect(
                origin: .zero,
                size: imageSize.scaled(by: weakSelf.scaleImageConstant)
            )
            
            containerLayer.backgroundColor = UIColor.clear.cgColor
            
            let blurLayer = CALayer()
            
            blurLayer.frame = CGRect(
                origin: .zero,
                size: imageSize
            )
            
            blurLayer.position = CGPoint(
                x: containerLayer.bounds.midX,
                y: containerLayer.bounds.midY
            )
            
            let blurImage = image.applyBlurWithRadius(
                0,
                tintColor: weakSelf.shadowColor,
                saturationDeltaFactor: weakSelf.shadowSaturation
            )
            
            blurLayer.contents = blurImage?.cgImage
            
            blurLayer.masksToBounds = false
            
            containerLayer.addSublayer(blurLayer)
            
            let containerImage = containerLayer.image(ofSize: containerLayer.frame.size)
            
            let resizeImageConstant: CGFloat = weakSelf.highPerformanceBlur ? 0.3 : 1
            
            guard
                let resizedContainerImage = containerImage.resized(withPercentage: resizeImageConstant),
                let blurredImage = resizedContainerImage.applyBlur(blurRadius: weakSelf.blurRadius)
            else { return }
            
            DispatchQueue.main.async {
                
                weakSelf.layer.masksToBounds = false
                
                weakSelf.shadowImageView.image = blurredImage
                
            }
            
        }
        
    }
    
}
