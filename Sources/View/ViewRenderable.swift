//
//  ViewRenderable.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRenderable

import UIKit

public protocol ViewRenderable {
    
    var view: View { get }

    var preferredContentSize: CGSize { get }
    
}
