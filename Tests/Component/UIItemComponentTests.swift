//
//  UIItemComponentTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 16/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIItemComponentTests

import XCTest

@testable import TinyKit

internal final class UIItemComponentTests: XCTestCase {

    internal final func testInitializeItemComponent() {
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redComponent = UIItemComponent(itemView: redView)

        // Before rendering.
        XCTAssertEqual(
            redComponent.itemView.frame,
            .zero
        )
        
        XCTAssertEqual(
            redComponent.view.frame,
            redComponent.itemView.frame
        )
        
        XCTAssertEqual(
            redComponent.itemView.backgroundColor,
            .red
        )
        
        XCTAssertEqual(
            redComponent.view.backgroundColor,
            redComponent.itemView.backgroundColor
        )
        
        // Expect to change back to red after rendering.
        redComponent.view.backgroundColor = .blue
        
        redComponent.render()
        
        // After rendering.
        XCTAssertEqual(
            redComponent.itemView.frame,
            .zero
        )
        
        XCTAssertEqual(
            redComponent.view.frame,
            redComponent.itemView.frame
        )
        
        XCTAssertEqual(
            redComponent.itemView.backgroundColor,
            .red
        )
        
        XCTAssertEqual(
            redComponent.view.backgroundColor,
            redComponent.itemView.backgroundColor
        )
        
    }
    
    internal final func testRenderWithContentModeSize() {

        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redComponent = UIItemComponent(itemView: redView)
        
        let size = CGSize(
            width: 100.0,
            height: 50.0
        )
        
        redComponent.contentMode = .size(size)
        
        redComponent.render()

        XCTAssertEqual(
            redComponent.itemView.frame,
            CGRect(
                origin: .zero,
                size: size
            )
        )

        XCTAssertEqual(
            redComponent.view.frame,
            redComponent.itemView.frame
        )

    }
    
    internal final func testRenderWithContentModeAutomatic() {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.text = "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor. Vestibulum id ligula porta felis euismod semper."
        
        let estimatedSize = CGSize(
            width: 50.0,
            height: 50.0
        )
        
        let expectedSize = label.sizeThatFits(estimatedSize)
        
        XCTAssertNotEqual(
            expectedSize,
            .zero
        )
        
        XCTAssertNotEqual(
            expectedSize,
            estimatedSize
        )
        
        let labelComponent = UIItemComponent(
            contentMode: .automatic2(estimatedSize: estimatedSize),
            itemView: label
        )
        
        labelComponent.render()
        
        XCTAssertEqual(
            labelComponent.view.frame.size,
            expectedSize
        )
        
    }

}
