//
//  Reusable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/8/18.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Reusable

public protocol Reusable {

    static var reuseIdentifier: String { get }

}

// MARK: - Reusable (Default Implementation)

public extension Reusable {

    public static var reuseIdentifier: String { return String(describing: self) }

}
