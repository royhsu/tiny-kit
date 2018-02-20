//
//  UIMessage.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 20/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIMessage

public struct UIMessage {

    public var title: String?

    public var text: String?

    public init(
        title: String? = nil,
        text: String? = nil
    ) {

        self.title = title

        self.text = text

    }

}
