//
//  UIBoxComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/4/8.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIBoxComponent

/// A part of layout components.
/// Providing a easy way to wrap a component as the content with the custom padding insets.
public final class UIBoxComponent: Component {
    
    /// The base component.
    private final let contentComponent: Component
    
    private final let leadingConstraint: NSLayoutConstraint
    
    private final let topConstraint: NSLayoutConstraint
    
    private final let trailingConstraint: NSLayoutConstraint
    
    private final let bottomConstraint: NSLayoutConstraint
    
    public final var paddingInsets: UIEdgeInsets
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        contentComponent: Component
    ) {
        
        self.contentComponent = contentComponent
        
        self.view = View()
        
        let contentView = contentComponent.view
        
        self.leadingConstraint = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        self.topConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor)
        
        self.trailingConstraint = view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        
        self.bottomConstraint = view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        self.paddingInsets = UIEdgeInsets(
            top: topConstraint.constant,
            left: leadingConstraint.constant,
            bottom: bottomConstraint.constant,
            right: trailingConstraint.constant
        )
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        view.backgroundColor = .clear
        
        trailingConstraint.priority = UILayoutPriority(900.0)
        
        bottomConstraint.priority = UILayoutPriority(900.0)
        
    }
    
    // MARK: Component
    
    public var contentMode: ComponentContentMode {
        
        get { return contentComponent.contentMode }
        
        set { contentComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let contentView = contentComponent.view
        
        contentView.removeFromSuperview()
        
        view.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        topConstraint.constant = -paddingInsets.top
        
        leadingConstraint.constant = -paddingInsets.left
        
        bottomConstraint.constant = paddingInsets.bottom
        
        trailingConstraint.constant = paddingInsets.right
        
        NSLayoutConstraint.activate(
            [
                leadingConstraint,
                topConstraint,
                trailingConstraint
            ]
        )
        
        contentComponent.render()
        
        view.bounds = contentView.bounds
        
        NSLayoutConstraint.activate(
            [ bottomConstraint ]
        )
        
    }
    
    // MARK: ViewRenderable
    
    public final let view: View
    
    public final var preferredContentSize: CGSize { return view.bounds.size }
    
}
