//
//  UIView+Subview.swift
//  TinyKit
//
//  Created by Roy Hsu on 11/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Subview

// Reference: https://stackoverflow.com/questions/26652854/ios8-cell-constraints-break-when-adding-disclosure-indicator

public extension UIView {

    public struct EdgeConstraints {

        public let topConstraint: NSLayoutConstraint

        public let leadingConstraint: NSLayoutConstraint

        public let bottomConstraint: NSLayoutConstraint

        public let trailingConstraint: NSLayoutConstraint

        public init(
            top topConstraint: NSLayoutConstraint,
            leading leadingConstraint: NSLayoutConstraint,
            bottom bottomConstraint: NSLayoutConstraint,
            trailing trailingConstraint: NSLayoutConstraint
        ) {

            self.topConstraint = topConstraint

            self.leadingConstraint = leadingConstraint

            self.bottomConstraint = bottomConstraint

            self.trailingConstraint = trailingConstraint

        }

    }

    /// A convenient method to add subview and pin its edges to the parent view.
    @discardableResult
    public final func wrapSubview(
        _ view: UIView,
        within guideKeyPath: KeyPath<UIView, UILayoutGuide>? = nil,
        constraintBuilder: ( (EdgeConstraints) -> Void )? = nil
    )
    -> EdgeConstraints {

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

        let topConstraint = view.topAnchor.constraint(equalTo: topAnchor)

        let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor)

        let bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor)

        bottomConstraint.priority = UILayoutPriority(900.0)

        let trailingConstraint = view.trailingAnchor.constraint(equalTo: trailingAnchor)

        trailingConstraint.priority = UILayoutPriority(900.0)

        let contraints = EdgeConstraints(
            top: topConstraint,
            leading: leadingConstraint,
            bottom: bottomConstraint,
            trailing: trailingConstraint
        )
        
        constraintBuilder?(contraints)

        NSLayoutConstraint.activate(
            [
                topConstraint,
                leadingConstraint,
                bottomConstraint,
                trailingConstraint
            ]
        )
        
        return contraints

    }

}
