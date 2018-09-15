//
//  Updatable.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Updatable

public protocol Updatable {
    
    associatedtype Value
    
    func updateValue(_ value: Value?)
    
}
