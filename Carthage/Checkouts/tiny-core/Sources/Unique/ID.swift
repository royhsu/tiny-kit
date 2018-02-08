//
//  ID.swift
//  TinyCore
//
//  Created by Roy Hsu on 17/07/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - ID

/// An identifier must be unique.
public protocol ID: RawRepresentable, Codable { }

// MARK: - Equatable (Default Implementation)

public extension ID where RawValue: Equatable {

    // swiftlint:disable operator_whitespace
    public static func ==(
        lhs: Self,
        rhs: Self
    )
    -> Bool { return lhs.rawValue == rhs.rawValue }
    // swiftlint:enabled operator_whitespace

}

// MARK: - Hashable (Default Implementation)

public extension ID where RawValue: Hashable {

    public var hashValue: Int { return rawValue.hashValue }

}

// MARK: - CustomStringConvertible (Default Implementation)

public extension ID where RawValue: CustomStringConvertible {

    public var description: String { return rawValue.description }

}

// MARK: - Codable (Default Implementation)

public extension ID where RawValue: Codable {

    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()

        let rawValue = try container.decode(RawValue.self)

        self.init(rawValue: rawValue)!

    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()

        try container.encode(rawValue)

    }

}
