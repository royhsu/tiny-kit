//
//  UIScrollView+SafeArea.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/23.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Safe Area

#warning("TODO: needs to seriously test.")
public extension UIScrollView {

    // swiftlint:disable identifier_name
    public final var layoutFrame: CGRect {

        let x: CGFloat

        let y: CGFloat

        let width: CGFloat

        let height: CGFloat

        if #available(iOS 11.0, *) {

            let layoutFrame = safeAreaLayoutGuide.layoutFrame

            x = adjustedContentInset.left

            y = adjustedContentInset.top

            let expectedWidth = layoutFrame.width
                - x
                - adjustedContentInset.right

            let expectedHeight = layoutFrame.height
                - y
                - adjustedContentInset.bottom

            width = max(
                0.0,
                expectedWidth
            )

            height = max(
                0.0,
                expectedHeight
            )

        }
        else {

            x = contentInset.left

            y = contentInset.top

            let expectedWidth = bounds.width
                - x
                - contentInset.right

            let expectedHeight = bounds.height
                - y
                - contentInset.bottom

            width = max(
                0.0,
                expectedWidth
            )

            height = max(
                0.0,
                expectedHeight
            )

        }

        return CGRect(
            x: x,
            y: y,
            width: width,
            height: height
        )

    }
    // swiftlint:enable identifier_name

}
