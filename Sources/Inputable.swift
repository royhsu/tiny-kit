//
//  Inputable.swift
//  TinyCore
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Inputable

public protocol Inputable {
    
    associatedtype T
    
    var input: Observable<T> { get }
    
}
