//
//  UINumberPickerInputValidator.swift
//  TinyUI
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerInputValidator

import TinyCore

public struct UINumberPickerInputValidator: Validator {

    public let minimumValue: Int

    public let maximumValue: Int

    public init(
        minimumValue: Int,
        maximumValue: Int
    ) {

        if minimumValue > maximumValue {

            fatalError("You must specify a minimum number that is less than or equal to the maximum number.")

        }

        self.minimumValue = minimumValue

        self.maximumValue = maximumValue

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
            newValue >= minimumValue,
            newValue <= maximumValue
        else {

            let error: UINumberPickerError = .invalidNumber(
                value: value,
                validMinimum: minimumValue,
                validMaximum: maximumValue
            )

            return .failure(error)

        }

        return .success(newValue)

    }

}
