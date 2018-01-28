//
//  ItemComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ItemComponentTests

import XCTest

@testable import TinyKit

internal final class ItemComponentTests: XCTestCase {
    
    internal final func testItemComponent() {
        
        let color = Color(
            red: 1.0,
            green: 0.0,
            blue: 0.0,
            alpha: 1.0
        )
        
        let colorComponent = ItemComponent(
            view: RectangleView(),
            model: color,
            binding: { colorView, color in
                
                colorView.backgroundColor = color.uiColor()
                
            }
        )
        
        let preferredContentSize = CGSize(
            width: 50.0,
            height: 50.0
        )
        
        colorComponent.preferredContentSize = preferredContentSize
        
        guard
            let colorView = colorComponent.view as? RectangleView
        else {
            
            XCTFail("Not the subclass of RectangelView.")
            
            return
            
        }
        
        XCTAssertEqual(
            colorView.backgroundColor,
            color.uiColor()
        )
        
        XCTAssertEqual(
            colorView.frame.size,
            colorComponent.preferredContentSize
        )
        
//        let containerView = UIView()
//
//        do {
//
//            try containerView.render(
//                AnyCollection([ colorComponent ])
//            )
//
//            XCTAssert(colorComponent.view.superview === containerView)
//
//

//
//        }
//        catch { XCTFail("\(error)") }
        
    }
    
}
