//
//  ViewRender.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRender

import TinyCore

/// A view render should define its own way to renderables.
/// It can also ignore the preferred content size of renderables if it makes sense.
public protocol ViewRender {
    
    var renderables: AnyCollection<ViewRenderable> { get }
    
    func render() -> Promise<Void>
    
}
