//
//  UITextFieldBridge.swift
//  TinyKit
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITextFieldBridge

public final class UITextFieldBridge: NSObject {
    
    public final unowned let textField: UITextField
    
    public typealias DidEndEditing = (_ textField: UITextField) -> Void
    
    public final var didEndEditing: DidEndEditing?
    
    public typealias ShouldChangeCharactersHandler = (
        _ textField: UITextField,
        _ range: NSRange,
        _ replacementString: String
    )
    -> Bool
    
    public final var shouldChangeCharactersHandler: ShouldChangeCharactersHandler?
    
    public init(textField: UITextField) {
        
        self.textField = textField
        
        super.init()
        
        textField.delegate = self
        
    }
    
}

// MARK: - UITextFieldDelegate

extension UITextFieldBridge: UITextFieldDelegate {
    
    public final func textFieldDidEndEditing(_ textField: UITextField) { didEndEditing?(textField) }
    
    public final func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    )
    -> Bool {
        
        let shouldChange = shouldChangeCharactersHandler?(
            textField,
            range,
            string
        )
        
        return shouldChange ?? true
        
    }
    
}
