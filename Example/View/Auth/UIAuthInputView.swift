//
//  UIAuthInputView.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAuthInputView

import UIKit

public final class UIAuthInputView: UIView {
    
    @IBOutlet
    public fileprivate(set) weak var label: UILabel!
    
    @IBOutlet
    public fileprivate(set) weak var textField: UITextField!
    
    // MARK: Life Cycle
    
    public final override func awakeFromNib() {
        
        setUpLabel(label)
        
        setUpTextField(textField)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpLabel(_ label: UILabel) {
        
        label.text = nil
        
        label.textAlignment = .right
        
        label.font = .preferredFont(forTextStyle: .subheadline)
        
    }
    
    fileprivate final func setUpTextField(_ textField: UITextField) { }
    
}
