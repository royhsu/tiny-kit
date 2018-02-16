//
//  TKItemComponentTests.swift
//  TinyKit
//
//  Created by Roy Hsu on 16/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - TKItemComponentTests

import XCTest

@testable import TinyKit

internal final class TKItemComponentTests: XCTestCase {
    
    internal final func testRenderItemComponent() {
        
        let rectangleSize = CGSize(
            width: 50.0,
            height: 50.0
        )
        
        let rectangleView = RectangleView()
        
        let rectangleItemComponent = TKItemComponent(
            contentMode: .size(
                width: rectangleSize.width,
                height: rectangleSize.height
            ),
            itemView: rectangleView
        )
        
        rectangleItemComponent.render()
        
        XCTAssertEqual(
            rectangleItemComponent.itemView,
            rectangleView
        )
        
        XCTAssertEqual(
            rectangleItemComponent.itemView.bounds.size,
            rectangleItemComponent.view.bounds.size
        )
        
        XCTAssertEqual(
            rectangleItemComponent.preferredContentSize,
            rectangleSize
        )
        
    }
    
}
