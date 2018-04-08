//
//  UIOptionDescriptor.swift
//  TinyStore
//
//  Created by Roy Hsu on 20/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIOptionDescriptor

public struct UIOptionDescriptor {

    public typealias ActionHandler = () -> Void

    public let title: String

    public let handler: ActionHandler

    public init(
        title: String,
        handler: @escaping ActionHandler
    ) {

        self.title = title

        self.handler = handler

    }

}
