//
//  Component.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Component

public protocol Component: class, ViewRenderable {

    /// The parent component may override the content mode of its child components.
    var contentMode: ComponentContentMode { get set }
    
    /// A component should render at least once for showing its content.
    /// The rendering should only happen on the main thread.
    func render()

}
