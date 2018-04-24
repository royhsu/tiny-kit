//
//  UIButtonComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIButtonComponent

import TinyCore

public protocol UIButtonComponent: Component {
    
    var eventEmitter: EventEmitter<UIButtonEvent> { get }
    
}
