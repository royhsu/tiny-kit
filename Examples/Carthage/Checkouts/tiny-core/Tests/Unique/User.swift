//
//  User.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 22/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - User

import TinyCore

internal struct User: Unique, Codable {

    // swiftlint:disable type_name
    internal typealias ID = UserID
    // swiftlint:enable type_name

    internal let id: AnyID<ID>

    internal let name: String

    internal init(
        id: ID,
        name: String
    ) {

        self.id = AnyID(id)

        self.name = name

    }

}

extension User: Equatable { }
