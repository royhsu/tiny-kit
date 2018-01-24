//
//  ComponentNode.swift
//  TinyKit
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentNode

open class ComponentNode {
    
    public fileprivate(set) final weak var parentComponentNode: ComponentNode?
    
    public fileprivate(set) final var childComponentNodes: [ComponentNode] = []
    
}

public extension ComponentNode {
    
    public final func addChildComponent(_ node: ComponentNode) {
        
        childComponentNodes.append(node)
        
        node.parentComponentNode = self
        
    }
    
    public final func removeFromParentComponentNode() {
        
        guard
            let index = parentComponentNode?.childComponentNodes.index(
                where: { $0 === self }
            )
        else { return }
        
        parentComponentNode?.childComponentNodes.remove(at: index)
        
        parentComponentNode = nil
        
    }
    
}

// MARK: - Node

extension ComponentNode: Node {
    
    public final var parent: Node? { return parentComponentNode }
    
    public final var childs: AnyCollection<Node> {
        
        let nodes: [Node] = childComponentNodes
        
        return AnyCollection(nodes)
        
    }
    
    public final func addChild(_ node: Node) {
        
        guard
            let componentNode = node as? ComponentNode
        else { fatalError("Cannot add a node that is not component node.") }
        
        addChildComponent(componentNode)
        
    }
    
    public final func removeFromParent() { removeFromParentComponentNode() }
    
}
