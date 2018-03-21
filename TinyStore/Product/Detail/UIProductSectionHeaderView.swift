//
//  UIProductSectionHeaderView.swift
//  TinyStore
//
//  Created by Roy Hsu on 13/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProductSectionHeaderView

public final class UIProductSectionHeaderView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var iconImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpIconImageView(iconImageView)
        
        setUpTitleLabel(titleLabel)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpIconImageView(_ imageView: UIImageView) {
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.tintColor = .black
        
    }
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        label.font = UIFont.systemFont(
            ofSize: 10.0,
            weight: .medium
        )
        
        label.text = nil
        
        label.textColor = .black
        
    }
    
}
