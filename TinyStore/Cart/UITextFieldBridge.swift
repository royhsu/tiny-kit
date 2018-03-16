//
//  UITextFieldBridge.swift
//  TinyStore
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITextFieldBridge

internal final class UITextFieldBridge: NSObject {
    
    internal final unowned let textField: UITextField
    
    internal typealias DidEndEditing = (_ textField: UITextField) -> Void
    
    internal final var didEndEditing: DidEndEditing?
    
    internal typealias ShouldChangeCharactersHandler = (
        _ textField: UITextField,
        _ range: NSRange,
        _ replacementString: String
    )
    -> Bool
    
    internal final var shouldChangeCharactersHandler: ShouldChangeCharactersHandler?
    
    internal init(textField: UITextField) {
        
        self.textField = textField
        
        super.init()
        
        textField.delegate = self
        
    }
    
}

// MARK: - UITextFieldDelegate

extension UITextFieldBridge: UITextFieldDelegate {
    
    internal final func textFieldDidEndEditing(_ textField: UITextField) { didEndEditing?(textField) }
    
    internal final func textField(
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
