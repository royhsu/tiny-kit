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

    // TODO: deprecating this method.
    public final func render(with renderable: ViewRenderable) {

        let contentView = renderable.view

        contentView.removeFromSuperview()

        contentView.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        bottomConstraint.priority = UILayoutPriority(900.0)

        addSubview(contentView)

        NSLayoutConstraint.activate(
            [
                leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                topAnchor.constraint(equalTo: contentView.topAnchor),
                trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                bottomConstraint
            ]
        )

    }

}

public extension UIView {
    
    /// A convenient method to add subview and pin it to edges to the parent with Auto Layout.
    public final func wrapSubview(_ view: View) {
        
        view.removeFromSuperview()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        bottomConstraint.priority = UILayoutPriority(900.0)
        
        addSubview(view)
        
        NSLayoutConstraint.activate(
            [
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                topAnchor.constraint(equalTo: view.topAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomConstraint
            ]
        )
        
    }
    
}
