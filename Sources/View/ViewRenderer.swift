//
//  ViewRenderer.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRenderer

/// A view renderer can ignore the preferred content size of the renderable if it makes sense.
public protocol ViewRenderer {

    func render(with renderable: ViewRenderable)

}
