//
//  ViewRenderable.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRenderable

public protocol ViewRenderable {

    var view: View { get }

    // TODO: drop this property. not be used so much.
    var preferredContentSize: CGSize { get }

}
