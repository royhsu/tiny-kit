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

    internal final func testRender() {
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let redComponent = UIItemComponent(itemView: redView)

        XCTAssertEqual(
            redComponent.contentMode,
            .automatic(estimatedSize: .zero)
        )
        
        XCTAssertNotEqual(
            redComponent.itemView,
            redComponent.view
        )
        
        // Before rendering.
        XCTAssertEqual(
            redComponent.view.frame,
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
            redComponent.view.frame,
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
    
    internal final func testRenderLayoutForNonIntrinsicContentWithModeSize() {

        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let size = CGSize(
            width: 100.0,
            height: 50.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .size(size),
            itemView: redView
        )
        
        redComponent.render()

        XCTAssertEqual(
            redComponent.itemView.frame,
            CGRect(
                origin: .zero,
                size: size
            )
        )

        XCTAssertEqual(
            redComponent.view.bounds,
            redComponent.itemView.frame
        )

    }
    
    internal final func testRenderLayoutForNonIntrinsicContentWithModeAutomatic() {
        
        let redView = UIView()
        
        redView.backgroundColor = .red
        
        let size = CGSize(
            width: 100.0,
            height: 50.0
        )
        
        let redComponent = UIItemComponent(
            contentMode: .automatic(estimatedSize: size),
            itemView: redView
        )
        
        redComponent.render()
        
        XCTAssertEqual(
            redComponent.itemView.frame,
            CGRect(
                origin: .zero,
                size: size
            )
        )
        
        XCTAssertEqual(
            redComponent.view.bounds,
            redComponent.itemView.frame
        )
        
    }
    
    internal final func testRenderLayoutForIntrinsicContentWithModeSize() {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.text = "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor. Vestibulum id ligula porta felis euismod semper."
        
        let estimatedSize = CGSize(
            width: 50.0,
            height: 50.0
        )
        
        let expectedSize = label.sizeThatFits(estimatedSize)
        
        XCTAssertNotEqual(
            .zero,
            expectedSize
        )
        
        XCTAssertNotEqual(
            estimatedSize,
            expectedSize
        )
        
        let labelComponent = UIItemComponent(
            contentMode: .size(estimatedSize),
            itemView: label
        )
        
        labelComponent.render()
        
        XCTAssertEqual(
            labelComponent.view.frame.size,
            estimatedSize
        )
        
        XCTAssertNotEqual(
            labelComponent.view.frame.size,
            expectedSize
        )
        
    }
    
    internal final func testRenderLayoutForIntrinsicContentWithModeAutomatic() {
        
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.text = "Maecenas faucibus mollis interdum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Curabitur blandit tempus porttitor. Vestibulum id ligula porta felis euismod semper."
        
        let estimatedSize = CGSize(
            width: 50.0,
            height: 50.0
        )
        
        let expectedSize = label.sizeThatFits(estimatedSize)
        
        XCTAssertNotEqual(
            .zero,
            expectedSize
        )
        
        XCTAssertNotEqual(
            estimatedSize,
            expectedSize
        )
        
        let labelComponent = UIItemComponent(
            contentMode: .automatic(estimatedSize: estimatedSize),
            itemView: label
        )
        
        labelComponent.render()
        
        XCTAssertEqual(
            labelComponent.view.frame.size,
            expectedSize
        )
        
    }

}