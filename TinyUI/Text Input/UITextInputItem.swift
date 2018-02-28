//
//  UITextInputItem.swift
//  TinyUI
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UITextInput

public struct UITextInputItem {

    public var title: String

    public var placeholder: String?

    public var isSecured: Bool

    public init(
        title: String,
        placeholder: String? = nil,
        isSecured: Bool = false
    ) {

        self.title = title

        self.placeholder = placeholder

        self.isSecured = isSecured

    }

}
