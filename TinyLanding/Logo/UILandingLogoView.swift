//
//  UILandingLogoView.swift
//  TinyLanding
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILandingLogoView

public final class UILandingLogoView: UIView {
    
    @IBOutlet
    public fileprivate(set) final var logoImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final var backgroundImageView: UIImageView!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpLogoImageView(logoImageView)
        
        setUpBackgroundImageView(backgroundImageView)
        
    }
    
    // MARK: Set Up

    fileprivate final func setUpLogoImageView(_ imageView: UIImageView) {
        
        imageView.contentMode = .scaleAspectFill
        
    }
    
    fileprivate final func setUpBackgroundImageView(_ imageView: UIImageView) {
        
        imageView.contentMode = .scaleAspectFill
        
    }
    
}
