//
//  UIView+ViewRenderer.swift
//  TinyKit
//
//  Created by Roy Hsu on 11/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewRenderer

import UIKit

extension UIView: ViewRenderer {

    public final func render(with renderable: ViewRenderable) {

        frame.size = renderable.preferredContentSize

        let contentView = renderable.view

        contentView.removeFromSuperview()

        contentView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(contentView)
        
        NSLayoutConstraint.activate(
            [
                leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                topAnchor.constraint(equalTo: contentView.topAnchor),
                trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )

    }

}
