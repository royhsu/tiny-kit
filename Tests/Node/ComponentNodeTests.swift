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
    
    internal final func testAddChildComponentNode() {
        
        let node = ComponentNode()
        
        let childNode = ComponentNode()
        
        node.addChildComponent(childNode)
        
        XCTAssert(
            node.childComponentNodes.contains(
                where: { $0 === childNode }
            )
        )
        
    }
    
    internal final func testAddChildNode() {
        
        let node = ComponentNode()
        
        let childNode = ComponentNode()
        
        node.addChild(childNode)
        
        XCTAssert(
            node.childs.contains(
                where: { $0 as? ComponentNode === childNode }
            )
        )
        
    }
    
}
