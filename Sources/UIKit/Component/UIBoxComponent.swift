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
    private final let containerComponent: UIItemComponent<View>
    
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
        
        let containerView = View()
        
        self.containerComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: containerView
        )
        
        self.contentComponent = contentComponent
        
        let contentView = contentComponent.view
        
        self.leadingConstraint = containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        self.topConstraint = containerView.topAnchor.constraint(equalTo: contentView.topAnchor)
        
        self.trailingConstraint = containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        
        self.bottomConstraint = containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
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
        
        let containerView = containerComponent.view
        
        containerView.backgroundColor = .clear
        
        trailingConstraint.priority = UILayoutPriority(900.0)
        
        bottomConstraint.priority = UILayoutPriority(900.0)
        
    }
    
    // MARK: Component
    
    public var contentMode: ComponentContentMode {
        
        get { return contentComponent.contentMode }
        
        set { contentComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        let containerView = containerComponent.itemView
        
        // Prepare for content to render.
        containerComponent.render()
        
        let contentView = contentComponent.view
        
        contentView.removeFromSuperview()
        
        contentView.frame = containerView.bounds
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentView)
        
        topConstraint.constant = -paddingInsets.top
        
        leadingConstraint.constant = -paddingInsets.left
        
        bottomConstraint.constant = paddingInsets.bottom
        
        trailingConstraint.constant = paddingInsets.right
        
        NSLayoutConstraint.activate(
            [
                leadingConstraint,
                topConstraint,
                trailingConstraint,
                bottomConstraint
            ]
        )
        
        contentComponent.render()
        
        // Render to fit the parent.
        containerComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return containerComponent.view }
    
    public final var preferredContentSize: CGSize { return containerComponent.view.bounds.size }
    
}
