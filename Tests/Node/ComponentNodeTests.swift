//
//  ComponentNodeTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 24/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ComponentNodeTests

import XCTest

@testable import TinyKit

internal final class ComponentNodeTests: XCTestCase {
    
    internal final func testAddChildAndRemoveFromParentComponentNode() {
        
        let node = ComponentNode()
        
        let childNode = ComponentNode()
        
        node.addChildComponent(childNode)
        
        XCTAssert(
            node.childComponentNodes.contains(
                where: { $0 === childNode }
            )
        )
        
        XCTAssert(
            childNode.parentComponentNode === node
        )
        
        childNode.removeFromParentComponentNode()
        
        XCTAssert(node.childComponentNodes.isEmpty)
        
        XCTAssertNil(childNode.parentComponentNode)
        
    }
    
    internal final func testAddChildAndRemoveFromParentNode() {
        
        let node = ComponentNode()
        
        let childNode = ComponentNode()
        
        node.addChild(childNode)
        
        XCTAssert(
            node.childs.contains(
                where: { $0 as? ComponentNode === childNode }
            )
        )
        
        let parentNode = childNode.parent as? ComponentNode
        
        XCTAssert(parentNode === node)
        
        childNode.removeFromParent()
        
        XCTAssert(node.childs.isEmpty)
        
        XCTAssertNil(childNode.parent)
        
    }
    
}
