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

    internal final func testRenderItemComponent() {

        let promise = expectation(description: "Render an item component.")

        let contentSize = CGSize(
            width: 50.0,
            height: 100.0
        )

        let colorView = RectangleView()

        let color = Color(
            red: 1.0,
            green: 0.0,
            blue: 0.0,
            alpha: 1.0
        )

        let colorComponent = ColorComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            ),
            view: colorView,
            model: color,
            binding: { colorView, color in

                colorView.backgroundColor = color.uiColor()

            }
        )

        colorComponent
            .render()
            .then(in: .main) {

                XCTAssertEqual(
                    colorComponent.preferredContentSize,
                    contentSize
                )

                XCTAssertEqual(
                    colorComponent.itemView,
                    colorView
                )

                XCTAssertEqual(
                    colorComponent.itemView.backgroundColor,
                    color.uiColor()
                )

                XCTAssertEqual(
                    colorComponent.model,
                    color
                )

            }
            .catch(in: .main) { XCTFail("\($0)") }
            .always(in: .main) { promise.fulfill() }

        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }

}
