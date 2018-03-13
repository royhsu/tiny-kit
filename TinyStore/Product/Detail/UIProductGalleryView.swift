//
//  UIProductGalleryView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductGalleryView

public final class UIProductGalleryView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var imageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var triangleView: TriangleView!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpImageView(imageView)
        
        setUpTriangleView(triangleView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpImageView(_ imageView: UIImageView) {
        
        imageView.backgroundColor = .lightGray
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
    }
    
    fileprivate final func setUpTriangleView(_ triangleView: TriangleView) {
        
        triangleView.backgroundColor = .clear
        
        triangleView.triangleColor = .white
        
    }
    
}
