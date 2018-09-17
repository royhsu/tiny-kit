//
//  ActionDispatcher.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ActionDispatcher

public protocol ActionDispatcher: AnyObject {
    
    func dispatch(action: Action)
    
}
