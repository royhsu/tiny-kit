//
//  UIChainableButton.swift
//  TinyUI
//
//  Created by Roy Hsu on 19/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIChainableButton

public final class UIChainableButton: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var titleLabel: UILabel!
    
    public final override func awakeFromNib() { setUpTitleLabel(titleLabel) }
    
    // MARK: Set Up
    
    fileprivate final func setUpTitleLabel(_ label: UILabel) {
        
        label.text = "Title"
        
        label.textAlignment = .left
        
        label.numberOfLines = 1
        
        label.font = .systemFont(ofSize: 10.0)
        
        label.textColor = tintColor
        
    }
    
}
