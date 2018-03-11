//
//  UIGalleryImageView.swift
//  TinyStore
//
//  Created by Roy Hsu on 04/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIGalleryImageView

public final class UIGalleryImageView: UIView {
    
    @IBOutlet
    public fileprivate(set) weak var imageView: UIImageView!
    
    public final override func awakeFromNib() {
        
        setUpRootView(self)
        
        setUpImageView(imageView)
        
    }
    
    fileprivate final func setUpRootView(_ view: UIView) {
        
        view.backgroundColor = .clear
        
    }
    
    fileprivate final func setUpImageView(_ imageView: UIImageView) {
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
    }
    
}
