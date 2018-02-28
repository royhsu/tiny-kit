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
    public fileprivate(set) final var actionLabel: UILabel!
    
    @IBOutlet
    public fileprivate(set) final var actionView: UIView!
    
    @IBOutlet
    public fileprivate(set) final var actionButton: UIButton!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpActionLabel(actionLabel)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpActionLabel(_ label: UILabel) {
        
        label.textAlignment = .center
        
        label.text = nil
        
        label.numberOfLines = 1
        
    }
    
}
