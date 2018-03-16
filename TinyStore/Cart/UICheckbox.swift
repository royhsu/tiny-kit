//
//  UICheckbox.swift
//  TinyStore
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckbox

public final class UICheckbox: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var iconImageView: UIImageView!
    
    public final override func awakeFromNib() {
        
        setUpIconImageView(iconImageView)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpIconImageView(_ imageView: UIImageView) {
        
        imageView.contentMode = .center
        
    }
    
}
