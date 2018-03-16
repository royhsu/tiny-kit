//
//  UINumberPickerError.swift
//  TinyStore
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerError

public enum UINumberPickerError: Error {
    
    case invalidNumber(
        string: String,
        validMinimum: Int,
        validMaximum: Int
    )
    
}
