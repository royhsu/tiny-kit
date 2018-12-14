//
//  ViewCollection.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/12/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

//  MARK: - ViewCollection

public protocol ViewCollection: Emptible {
    
    var count: Int { get }
    
    subscript(index: Int) -> ViewRepresentable { get }
    
}

// MARK: - ViewCollection (Default Implementation)

public extension ViewCollection {
    
    public var isEmpty: Bool { return (count == 0) }
    
}
