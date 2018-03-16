//
//  UINumberPickerItem.swift
//  TinyStore
//
//  Created by Roy Hsu on 16/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UINumberPickerItem

public struct UINumberPickerItem {
    
    // TODO: move into validator
    public var minimumNumber: Int {
        
        didSet {
            
            validateNumberRange(
                minimum: minimumNumber,
                maximum: maximumNumber
            )
            
        }
        
    }
    
    // TODO: move into validator
    public var maximumNumber: Int {
        
        didSet {
            
            validateNumberRange(
                minimum: minimumNumber,
                maximum: maximumNumber
            )
            
        }
        
    }
    
    public var increaseIconImage: UIImage?
    
    public var increaseBackgroundColor: UIColor
    
    public var increaseTintColor: UIColor
    
    public var decreaseIconImage: UIImage?
    
    public var decreaseBackgroundColor: UIColor
    
    public var decreaseTintColor: UIColor
    
    public var number: Int {
        
        didSet { didChangeNumberHandler?(number) }
        
    }
    
    public typealias DidChangeNumberHandler = (_ number: Int) -> Void
    
    internal var didChangeNumberHandler: DidChangeNumberHandler?
    
    public init(
        minimumNumber: Int = 0,
        maximumNumber: Int = 10,
        increaseIconImage: UIImage? = nil,
        increaseBackgroundColor: UIColor = .lightGray,
        increaseTintColor: UIColor = .white,
        decreaseIconImage: UIImage? = nil,
        decreaseBackgroundColor: UIColor = .lightGray,
        decreaseTintColor: UIColor = .white,
        number: Int = 0
    ) {
        
        self.minimumNumber = minimumNumber
        
        self.maximumNumber = maximumNumber
        
        self.increaseIconImage = increaseIconImage
        
        self.increaseBackgroundColor = increaseBackgroundColor
        
        self.increaseTintColor = increaseTintColor
        
        self.decreaseIconImage = decreaseIconImage
        
        self.decreaseBackgroundColor = decreaseBackgroundColor
        
        self.decreaseTintColor = decreaseTintColor
        
        self.number = number
        
        validateNumberRange(
            minimum: minimumNumber,
            maximum: maximumNumber
        )
        
    }
    
    // MARK: Validation
    
    fileprivate func validateNumberRange(minimum: Int, maximum: Int) {
        
        if minimum > maximum {
            
            fatalError("You must specify a minimum number that is less than or equal to the maximum number.")
            
        }
        
    }
    
}
