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
    public final func wrapSubview(
        _ view: UIView,
        within guideKeyPath: KeyPath<UIView, UILayoutGuide>? = nil,
        constraintBuilder: ( (EdgeConstraints) -> Void )? = nil
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
            EdgeConstraints(
                top: topConstraint,
                leading: leadingConstraint,
                bottom: bottomConstraint,
                trailing: trailingConstraint
            )
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
