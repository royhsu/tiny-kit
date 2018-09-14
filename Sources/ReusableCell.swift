//
//  ReusableCell.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ReusableCell

public protocol ReusableCell {

    static var reuseIdentifier: String { get }

}

// MARK: - Default Implementation

public extension ReusableCell {

    public static var reuseIdentifier: String { return String(describing: self) }

}
