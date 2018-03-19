//
//  UICheckbox.swift
//  TinyUI
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICheckbox

public final class UICheckbox: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var iconImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var actionButton: UIButton!
    
    public final override func awakeFromNib() {
        
        setUpIconImageView(iconImageView)
        
        setUpActionButton(actionButton)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpIconImageView(_ imageView: UIImageView) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        imageView.image = UIImage(
            named: "icon-checkbox-checked",
            in: bundle,
            compatibleWith: nil
        )?
        .withRenderingMode(.alwaysTemplate)
        
        imageView.tintColor = tintColor
        
        imageView.contentMode = .center
        
    }
    
    fileprivate final func setUpActionButton(_ button: UIButton) {
        
        button.setTitle(
            nil,
            for: .normal
        )
        
    }
    
}
