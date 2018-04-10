//
//  UICollectionView+SafeAreaRect.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/10.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Safe Area Rect

public extension UICollectionView {
    
    public final var safeAreaRect: CGRect {
        
        let x = contentInset.left + safeAreaInsets.left
        
        let y = contentInset.top + safeAreaInsets.top
        
        var width = bounds.width
            - x
            - contentInset.right
            - safeAreaInsets.right
        
        if width < 0.0 { width = 0.0 }
        
        var height = bounds.height
            - y
            - contentInset.bottom
            - safeAreaInsets.bottom
        
        if height < 0.0 { height = 0.0 }
        
        return CGRect(
            x: x,
            y: y,
            width: width,
            height: height
        )
        
    }
    
}
