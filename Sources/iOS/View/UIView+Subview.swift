//
//  UIView+Subview.swift
//  TinyKit
//
//  Created by Roy Hsu on 11/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Subview

import UIKit

// Reference: https://stackoverflow.com/questions/26652854/ios8-cell-constraints-break-when-adding-disclosure-indicator

// swiftlint:disable large_tuple
public extension UIView {

    /// A convenient method to add subview and pin it to edges to the parent with Auto Layout.
    @available(*, deprecated: 1.0, message: "Please use wrapSubview(:within:constraintBuilder:) instead.")
    @discardableResult
    public final func wrapSubview(_ view: UIView) -> (
        topConstraint: NSLayoutConstraint,
        leadingConstraint: NSLayoutConstraint,
        bottomConstraint: NSLayoutConstraint,
        trailingConstraint: NSLayoutConstraint
    ) {

        view.removeFromSuperview()

        view.translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = topAnchor.constraint(equalTo: view.topAnchor)

        let leadingConstraint = leadingAnchor.constraint(equalTo: view.leadingAnchor)

        let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)

        bottomConstraint.priority = UILayoutPriority(900.0)

        let trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor)

        trailingConstraint.priority = UILayoutPriority(900.0)

        addSubview(view)

        NSLayoutConstraint.activate(
            [
                topConstraint,
                leadingConstraint,
                bottomConstraint,
                trailingConstraint
            ]
        )

        return (
            topConstraint,
            leadingConstraint,
            bottomConstraint,
            trailingConstraint
        )

    }
    
}
// swiftlint:enable large_tuple
    
public extension UIView {
    
    /// A convenient method to add subview and pin its edges to the parent view.
    public final func wrapSubview(
        _ view: UIView,
        within guideKeyPath: KeyPath<UIView, UILayoutGuide>? = nil,
        constraintBuilder: (
            (
                _ topConstraint: NSLayoutConstraint,
                _ leadingConstraint: NSLayoutConstraint,
                _ bottomConstraint: NSLayoutConstraint,
                _ trailingConstraint: NSLayoutConstraint
            )
            -> Void
        )? = nil
    ) {
        
        view.removeFromSuperview()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        let topAnchor: NSLayoutYAxisAnchor
        
        let leadingAnchor: NSLayoutXAxisAnchor
        
        let bottomAnchor: NSLayoutYAxisAnchor
        
        let trailingAnchor: NSLayoutXAxisAnchor
        
        if let keyPath = guideKeyPath {
            
            let guide = self[keyPath: keyPath]
            
            topAnchor = guide.topAnchor
            
            leadingAnchor = guide.leadingAnchor
            
            bottomAnchor = guide.bottomAnchor
            
            trailingAnchor = guide.trailingAnchor
            
        }
        else {
            
            topAnchor = self.topAnchor
            
            leadingAnchor = self.leadingAnchor
            
            bottomAnchor = self.bottomAnchor
            
            trailingAnchor = self.trailingAnchor
            
        }
        
        let topConstraint = topAnchor.constraint(equalTo: view.topAnchor)
        
        let leadingConstraint = leadingAnchor.constraint(equalTo: view.leadingAnchor)
        
        let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        bottomConstraint.priority = UILayoutPriority(900.0)
        
        let trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        trailingConstraint.priority = UILayoutPriority(900.0)
        
        constraintBuilder?(
            topConstraint,
            leadingConstraint,
            bottomConstraint,
            trailingConstraint
        )
        
        NSLayoutConstraint.activate(
            [
                topConstraint,
                leadingConstraint,
                bottomConstraint,
                trailingConstraint
            ]
        )
        
    }

}
