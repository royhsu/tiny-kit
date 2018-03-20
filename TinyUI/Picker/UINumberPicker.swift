//
//  UINumberPicker.swift
//  TinyUI
//
//  Created by Roy Hsu on 15/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPicker

public final class UINumberPicker: UIView {
    
    @IBOutlet
    public fileprivate(set) final weak var increaseIconImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var increaseContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var decreaseIconImageView: UIImageView!
    
    @IBOutlet
    public fileprivate(set) final weak var decreaseContainerView: UIView!

    @IBOutlet
    public fileprivate(set) final weak var numberContainerView: UIView!
    
    @IBOutlet
    public fileprivate(set) final weak var numberTextField: UITextField!
    
    public final override func awakeFromNib() {
        
        setUpRootView(self)
        
        setUpIncreaseIconImageView(increaseIconImageView)
        
        setUpIncreaseContainerView(increaseContainerView)
        
        setUpDecreaseIconImageView(decreaseIconImageView)
        
        setUpDecreaseContainerView(decreaseContainerView)
        
        setUpNumberContainerView(numberContainerView)
        
        setUpNumberTextField(numberTextField)
        
    }
    
    // MARK: Set Up
    
    fileprivate final func setUpRootView(_ view: UIView) {
        
        view.layer.cornerRadius = 2.0
        
        view.clipsToBounds = true
        
        view.backgroundColor = tintColor
        
    }
    
    fileprivate final func setUpIncreaseIconImageView(_ imageView: UIImageView) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        let image = UIImage(
            named: "icon-plus",
            in: bundle,
            compatibleWith: nil
        )
        
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        
        imageView.tintColor = .white
        
        imageView.contentMode = .scaleAspectFill
        
    }
    
    fileprivate final func setUpIncreaseContainerView(_ view: UIView) { view.backgroundColor = nil }
    
    fileprivate final func setUpDecreaseIconImageView(_ imageView: UIImageView) {
        
        let bundle = Bundle(
            for: type(of: self)
        )
        
        let image = UIImage(
            named: "icon-minus",
            in: bundle,
            compatibleWith: nil
        )
        
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        
        imageView.tintColor = .white
        
        imageView.contentMode = .scaleAspectFill
        
    }
    
    fileprivate final func setUpDecreaseContainerView(_ view: UIView) { view.backgroundColor = nil }
    
    fileprivate final func setUpNumberContainerView(_ view: UIView) { view.backgroundColor = .white }
    
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
