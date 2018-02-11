//
//  AnyID.swift
//  TinyCore
//
//  Created by Roy Hsu on 22/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnyID

/// The type erasure wrapper for ID.
public struct AnyID<R: RawRepresentable & Codable> {

    private let base: R

    public init(_ base: R) { self.base = base }

}

// MARK: - ID

extension AnyID: ID {

    // MARK: RawRepresentable

    public typealias RawValue = R

    public var rawValue: R { return base }

    public init?(rawValue: RawValue) { self.init(rawValue) }

    // MARK: Codable

    public init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()

        let base = try container.decode(R.self)

        self.init(base)

    }

    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()

        try container.encode(base)

    }

}
