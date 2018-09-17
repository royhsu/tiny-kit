//
//  Actionable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Actionable

public protocol Actionable: AnyObject {
    
    var dispatcher: ActionDispatcher? { get set }
    
}
