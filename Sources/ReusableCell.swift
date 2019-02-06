//
//  ReusableCell.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ReusableCell

#warning("TODO: rename to Reusable.")
public protocol ReusableCell {

    static var reuseIdentifier: String { get }

}

// MARK: - ReusableCell (Default Implementation)

public extension ReusableCell {

    public static var reuseIdentifier: String { return String(describing: self) }

}
