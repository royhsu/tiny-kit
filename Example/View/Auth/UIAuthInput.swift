//
//  UIAuthInput.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAuthInput

public struct UIAuthInput {

    public var name: String

    public var placeholder: String?

    public var isSecured: Bool

    public init(
        name: String,
        placeholder: String? = nil,
        isSecured: Bool = false
    ) {

        self.name = name

        self.placeholder = placeholder

        self.isSecured = isSecured

    }

}
