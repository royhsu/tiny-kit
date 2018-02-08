//
//  Unique.swift
//  TinyCore
//
//  Created by Roy Hsu on 17/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - Unique

/// We can easily distinguish different objects by comparing their ids if they all conform to this protocol.
public protocol Unique {

    // swiftlint:disable type_name
    associatedtype R: RawRepresentable, Codable
    // swiftlint:enable type_name

    var id: AnyID<R> { get }

}

// MARK: - Equatable (Default Implementation)

/// The default implementation only compares their ids. If you have objects that need more complex comparison, feel free to override this method and provide your own implementation.
public extension Unique where R: Equatable {

    // swiftlint:disable operator_whitespace
    public static func ==(
        lhs: Self,
        rhs: Self
    )
    -> Bool { return lhs.id == rhs.id }
    // swiftlint:enable operator_whitespace

}
