//
//  Component.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Component

public protocol Component: ViewRenderable {

    var contentMode: ComponentContentMode { get set }

    /// The rendering should only happen on the main thread.
    func render()

}

// MARK: - ComponentContentMode

public enum ComponentContentMode {

    case size(
        width: CGFloat,
        height: CGFloat
    )

    case automatic

}
