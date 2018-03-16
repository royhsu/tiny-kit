//
//  UINumberPickerView.swift
//  TinyStore
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerView

public final class UINumberPickerView: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var increaseIconImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var increaseButton: UIButton!
    
    @IBOutlet
    public fileprivate(set) final weak var decreaseIconImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var decreaseButton: UIButton!

    @IBOutlet
    public fileprivate(set) final weak var numberContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var numberTextField: UITextField!
    
    public final override func awakeFromNib() {
        
        setUpRootView(self)
        
        setUpIncreaseIconImageView(increaseIconImageView)
        
        setUpDecreaseIconImageView(decreaseIconImageView)
        
        setUpNumberContainerView(numberContainerView)
        
        setUpNumberTextField(numberTextField)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: UIView) {
        
        view.layer.cornerRadius = 2.0
        
        view.clipsToBounds = true
        
    }
    
    fileprivate final func setUpIncreaseIconImageView(_ imageView: UIImageView) { imageView.contentMode = .center }
    
    fileprivate final func setUpDecreaseIconImageView(_ imageView: UIImageView) { imageView.contentMode = .center }
    
    fileprivate final func setUpNumberContainerView(_ view: UIView) { view.backgroundColor = nil }
    
    let toolBar = UIToolbar()
    
    fileprivate final func setUpNumberTextField(_ textField: UITextField) {
        
        textField.borderStyle = .none
        
        textField.backgroundColor = nil
        
        textField.textAlignment = .center
        
        textField.font = .systemFont(ofSize: 14.0)
        
        textField.textColor = .black
        
        textField.text = "0"
        
        textField.keyboardType = .numberPad
        
    }
    
}
