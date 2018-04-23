//
//  UIBoxComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/4/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIBoxComponentTests

import XCTest

@testable import TinyKit

internal final class UIBoxComponentTests: XCTestCase {
    
    internal final func testRender() {
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redComponent = UIItemComponent(itemView: redView)
        
        let boxSize = CGSize(
            width: 50.0,
            height: 100.0
        )
        
        let boxComponent = UIBoxComponent(
            contentMode: .size(boxSize),
            contentComponent: redComponent
        )
        
        XCTAssertEqual(
            boxComponent.contentMode,
            .size(boxSize)
        )
        
        let containerComponent = boxComponent.containerComponent
        
        let contentComponent = boxComponent.contentComponent
        
        XCTAssertEqual(
            boxComponent.view,
            containerComponent.view
        )
        
        XCTAssertNotEqual(
            containerComponent.view,
            contentComponent.view
        )
        
        XCTAssertEqual(
            contentComponent.view,
            redComponent.view
        )
        
        XCTAssertEqual(
            containerComponent.view.bounds,
            contentComponent.view.frame
        )
        
        let paddingInsets = UIEdgeInsets(
            top: 1.0,
            left: 2.0,
            bottom: 3.0,
            right: 4.0
        )
        
        boxComponent.paddingInsets = paddingInsets
        
        boxComponent.render()
        
        XCTAssertEqual(
            boxComponent.view.frame,
            CGRect(
                origin: .zero,
                size: boxSize
            )
        )
        
        XCTAssertEqual(
            boxComponent.view.frame,
            containerComponent.view.frame
        )
        
        XCTAssertNotEqual(
            containerComponent.view.bounds,
            contentComponent.view.frame
        )
        
        XCTAssertEqual(
            contentComponent.view.frame,
            CGRect(
                x: paddingInsets.left,
                y: paddingInsets.top,
                width: containerComponent.view.frame.width - paddingInsets.left - paddingInsets.right,
                height: containerComponent.view.frame.height - paddingInsets.top - paddingInsets.bottom
            )
        )
        
        XCTAssertEqual(
            containerComponent.view.backgroundColor,
            contentComponent.view.backgroundColor
        )
        
        XCTAssertEqual(
            containerComponent.view.backgroundColor,
            .red
        )
        
    }
    
}
