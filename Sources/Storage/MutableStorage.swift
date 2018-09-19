//
//  MutableStorage.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/19.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MutableStorage

import TinyCore

public protocol MutableStorage: Storage {
    
    var isLoaded: Bool { get }
    
    mutating func load()
    
    subscript(key: Key) -> Value? { get set }
    
    mutating func merge<S>(
        _ other: S,
        options: ObservableValueOptions
    )
    where
        S: Sequence,
        S.Element == (key: Key, value: Value?)
    
}
