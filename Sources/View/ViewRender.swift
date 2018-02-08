//
//  ViewRender.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRender

import TinyCore

public protocol ViewRender {
    
    var renderables: AnyCollection<ViewRenderable> { get }
    
    /**
    A render should define its way to render objects.
    
     - Parameter renderables: The objects to be rendered.
    
     Note: View Render can ignore the preferred content size of renderables if it's reasonable.
    */
    
    func render() -> Promise<Void>
    
}
