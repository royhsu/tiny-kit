//
//  ColorViewFactory.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ColorViewFactory

import UIKit
import TinyKit

internal struct ColorViewFactory: ViewFactory {

    internal func makeView() -> RectangleView { return RectangleView() }
    
}
