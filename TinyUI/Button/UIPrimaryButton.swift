//
//  UIPrimaryButton.swift
//  TinyUI
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPrimaryButton

public final class UIPrimaryButton: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final weak var iconImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var actionButton: UIButton!
    
    public final override func awakeFromNib() {
        
        setUpTitleLabel(titleLabel)
        
        setUpIconImageView(iconImageView)
        
    }
    
    public final override func layoutSubviews() {
        
        layer.cornerRadius = (bounds.height / 2.0)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        label.textAlignment = .center
        
        label.text = nil
        
        label.numberOfLines = 1
        
        label.font = .systemFont(
            ofSize: 14.0,
            weight: .medium
        )
        
    }
    
    fileprivate final func setUpIconImageView(_ imageView: UIImageView) {
        
        imageView.contentMode = .center
        
    }
    
}
