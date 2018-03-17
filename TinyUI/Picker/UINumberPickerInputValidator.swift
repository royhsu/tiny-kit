//
//  UINumberPickerInputValidator.swift
//  TinyStore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerInputValidator

public struct UINumberPickerInputValidator: Validator {
    
    public let minimumNumber: Int
    
    public let maximumNumber: Int
    
    public init(
        minimumNumber: Int,
        maximumNumber: Int
    ) {
        
        if minimumNumber > maximumNumber {
            
            fatalError("You must specify a minimum number that is less than or equal to the maximum number.")
            
        }
        
        self.minimumNumber = minimumNumber
        
        self.maximumNumber = maximumNumber
        
    }
    
    public func validate(value: Any) -> Result<Int> {
        
        let newValue: Int
        
        if
            let stringValue = value as? String,
            let intValue = Int(stringValue) {
            
            newValue = intValue
            
        }
        else if let intValue = value as? Int { newValue = intValue }
        else { newValue = -1 }
        
        guard
            newValue >= minimumNumber,
            newValue <= maximumNumber
        else {
            
            let error: UINumberPickerError = .invalidNumber(
                value: value,
                validMinimum: minimumNumber,
                validMaximum: maximumNumber
            )
            
            return .failure(error)
                
        }
        
        return .success(newValue)
        
    }
    
}
