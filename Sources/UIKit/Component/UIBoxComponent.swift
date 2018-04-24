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
    internal final let containerComponent: UIItemComponent<UIView>
    
    internal final let contentComponent: Component
    
    private final let contentViewTopConstraint: NSLayoutConstraint
    
    private final let contentViewLeadingConstraint: NSLayoutConstraint
    
    private final let contentViewBottomConstraint: NSLayoutConstraint
    
    private final let contentViewTrailingConstraint: NSLayoutConstraint

    public final var paddingInsets: UIEdgeInsets
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero),
        contentComponent: Component
    ) {
        
        self.containerComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView()
        )
        
        self.contentComponent = contentComponent
        
        let containerView = containerComponent.itemView
        
        let contentView = contentComponent.view
        
        self.contentViewTopConstraint = containerView.topAnchor.constraint(equalTo: contentView.topAnchor)
        
        self.contentViewLeadingConstraint = containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        self.contentViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        self.contentViewTrailingConstraint = containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        
        self.paddingInsets = UIEdgeInsets(
            top: contentViewTopConstraint.constant,
            left: contentViewLeadingConstraint.constant,
            bottom: contentViewBottomConstraint.constant,
            right: contentViewTrailingConstraint.constant
        )
        
        self.prepare()
        
    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        prepareLayout()
        
        containerView.backgroundColor = contentView.backgroundColor
      
    }
    
    fileprivate final func prepareLayout() {
        
        contentViewBottomConstraint.priority = UILayoutPriority(900.0)
        
        contentViewTrailingConstraint.priority = UILayoutPriority(900.0)
        
        contentView.frame.size = CGSize(
            width: containerView.frame.width - paddingInsets.left - paddingInsets.right,
            height: containerView.frame.height - paddingInsets.top - paddingInsets.bottom
        )
        
        contentView.center = view.center
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return containerComponent.contentMode }
        
        set { containerComponent.contentMode = newValue }
        
    }
    
    public final func render() {
        
        renderLayout()
        
        containerView.backgroundColor = contentView.backgroundColor
        
    }
    
    fileprivate final func renderLayout() {
        
        let contentViewConstraints = [
            contentViewTopConstraint,
            contentViewLeadingConstraint,
            contentViewBottomConstraint,
            contentViewTrailingConstraint
        ]

        contentView.removeFromSuperview()

        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.deactivate(contentViewConstraints)

        containerView.addSubview(contentView)
        
        contentViewTopConstraint.constant = -paddingInsets.top
        
        contentViewLeadingConstraint.constant = -paddingInsets.left
        
        contentViewBottomConstraint.constant = paddingInsets.bottom
        
        contentViewTrailingConstraint.constant = paddingInsets.right
        
        NSLayoutConstraint.activate(contentViewConstraints)
        
        containerComponent.render()
        
        contentComponent.contentMode = .automatic(
            estimatedSize: CGSize(
                width: containerView.frame.width - paddingInsets.left - paddingInsets.right,
                height: containerView.frame.height - paddingInsets.top - paddingInsets.bottom
            )
        )
        
        contentComponent.render()
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return containerComponent.view }
    
    public final var preferredContentSize: CGSize { return view.bounds.size }
    
}

fileprivate extension UIBoxComponent {
    
    // The container view is equal to the item view but not the view of the container component due to the underlying implementation.
    fileprivate final var containerView: UIView { return containerComponent.itemView }
    
    fileprivate final var contentView: UIView { return contentComponent.view }
    
}
