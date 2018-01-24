//
//  Node.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Node

public protocol Node {
    
    var parent: Node? { get }
    
    var childs: AnyCollection<Node> { get }
    
    func addChild(_ node: Node)
    
    func removeFromParent()
    
}
