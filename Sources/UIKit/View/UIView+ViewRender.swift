//
//  UIView+ViewRenderer.swift
//  TinyKit
//
//  Created by Roy Hsu on 11/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Wrapping Subview

// Reference: https://stackoverflow.com/questions/26652854/ios8-cell-constraints-break-when-adding-disclosure-indicator
public extension UIView {
    
    /// A convenient method to add subview and pin it to edges to the parent with Auto Layout.
    public final func wrapSubview(_ view: View) {
        
        view.removeFromSuperview()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        trailingConstraint.priority = UILayoutPriority(900.0)
        
        let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        bottomConstraint.priority = UILayoutPriority(900.0)
        
        addSubview(view)
        
        NSLayoutConstraint.activate(
            [
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                topAnchor.constraint(equalTo: view.topAnchor),
                trailingConstraint,
                bottomConstraint
            ]
        )
        
    }
    
}
