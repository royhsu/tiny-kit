//
//  Component.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Component

import TinyCore

public protocol Component: ViewRenderable {
    
    /// The rendering should only happen on the main thread.
    func render() -> Promise<Void>
    
}
