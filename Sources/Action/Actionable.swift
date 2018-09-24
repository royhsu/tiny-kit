//
//  Actionable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Actionable

import TinyCore

public protocol Actionable {
    
    var actions: Observable<Action> { get }
    
}
