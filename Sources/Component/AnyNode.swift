//
//  AnyNode.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AnyNode

/// Type-erasure wrapper of Node.
public struct AnyNode {
    
    private let base: Node
    
    public init(_ base: Node) { self.base = base }
    
}

// MARK: - Node

extension AnyNode: Node {
    
    public var parent: Node? { return base.parent.map(AnyNode.init) }
    
    public var childs: AnyCollection<Node> { return AnyCollection(base.childs) }
    
    public func addChild(_ node: Node) { base.addChild(node) }
    
    public func removeFromParent() { base.removeFromParent() }
    
}
