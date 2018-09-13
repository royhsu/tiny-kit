//
//  Storage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Storage

import TinyCore

public protocol Storage {
    
    associatedtype Key: Hashable, Comparable
    
    associatedtype Value
    
    typealias KeyDiff = Observable<[Key]>
    
    var keyDiff: KeyDiff { get }
    
    var maxKey: Key? { get }
    
    subscript(_ key: Key) -> Value? { get }
    
}
