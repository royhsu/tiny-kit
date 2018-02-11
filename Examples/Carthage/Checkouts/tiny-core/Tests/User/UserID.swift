//
//  UserID.swift
//  TinyCore
//
//  Created by Roy Hsu on 04/08/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - UserID

import TinyCore

internal struct UserID: ID {

    // MARK: Property

    internal var rawValue: String

    // MARK: Init

    internal init(_ rawValue: String) {

        self.rawValue = rawValue

    }

}
