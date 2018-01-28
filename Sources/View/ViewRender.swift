//
//  ViewRender.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRender

public protocol ViewRender {
    
    /// Note: View Render can ignore the preferred content size of renderables if needed.
    func render(
        _ renderables: AnyCollection<ViewRenderable>
    )
    throws
    
}
