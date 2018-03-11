//
//  UISignIn.swift
//  TinyAuth
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UISignIn

public struct UISignIn {

    public var email: String?

    public var password: String?

    public init(
        email: String? = nil,
        password: String? = nil
    ) {

        self.email = email

        self.password = password

    }

}
