//
//  Int+RandomNumber.swift
//  TinyCore
//
//  Created by Roy Hsu on 07/09/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Random Number

public extension Int {

    /**
     A convenience method that generate a random number with the given range.
     
     - Author: Roy Hsu.
     
     - Parameter range: The range of numbers.
     
     - returns: A random number in the given range.
     */
    // Reference: http://stackoverflow.com/questions/24132399/how-does-one-make-random-number-between-range-for-arc4random-uniform

    public static func random(in range: Range<Int>) -> Int {

        let offset =
            (range.lowerBound < 0)
            ? abs(range.lowerBound)
            : 0

        let min = UInt32(range.lowerBound + offset)
        let max = UInt32(range.upperBound + offset)

        return Int(
            min
            + arc4random_uniform(max - min)
        )
        - offset

    }

}
