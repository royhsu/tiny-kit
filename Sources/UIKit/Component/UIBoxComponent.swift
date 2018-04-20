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
    
    private final let contentViewTopConstraint: NSLayoutConstraint
    
    private final let contentViewLeadingConstraint: NSLayoutConstraint
    
    private final let contentViewBottomConstraint: NSLayoutConstraint
    
    private final let contentViewTrailingConstraint: NSLayoutConstraint
    
    private final let contentViewWidthConstraint: NSLayoutConstraint
    
    private final let contentViewHeightConstraint: NSLayoutConstraint
    
    public final var paddingInsets: UIEdgeInsets
    
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero),
        contentComponent: Component
    ) {
        
        self.contentMode = contentMode
        
        self.view = View()
        
        self.contentComponent = contentComponent
        
        let contentView = contentComponent.view
        
        self.contentViewTopConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor)
        
        self.contentViewLeadingConstraint = view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        
        self.contentViewBottomConstraint = view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        self.contentViewTrailingConstraint = view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        
        self.contentViewWidthConstraint = view.widthAnchor.constraint(equalToConstant: contentView.frame.width)
        
        self.contentViewHeightConstraint = view.widthAnchor.constraint(equalToConstant: contentView.frame.height)
        
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
        
        view.backgroundColor = contentView.backgroundColor
      
        contentViewBottomConstraint.priority = UILayoutPriority(900.0)
        
        contentViewTrailingConstraint.priority = UILayoutPriority(900.0)
        
        contentViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        contentViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case let .automatic(estimatedSize): size = estimatedSize
            
        }
        
        view.frame.size = size
        
        contentView.frame.size = CGSize(
            width: view.frame.width - paddingInsets.left - paddingInsets.right,
            height: view.frame.height - paddingInsets.top - paddingInsets.bottom
        )
        
        contentView.center = view.center
        
    }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode
    
    public final func render() {
        
        let contentViewConstraints = [
            contentViewTopConstraint,
            contentViewLeadingConstraint,
            contentViewBottomConstraint,
            contentViewTrailingConstraint,
            contentViewWidthConstraint,
            contentViewHeightConstraint
        ]
        
        contentView.removeFromSuperview()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.deactivate(contentViewConstraints)
        
        switch contentMode {
            
        case let .size(size):
            
            var width = size.width - paddingInsets.left - paddingInsets.right
            
            if width < 0.0 { width = 0.0 }
            
            var height = size.height - paddingInsets.top - paddingInsets.bottom
            
            if height < 0.0 { height = 0.0 }
            
            contentComponent.contentMode = .automatic(
                estimatedSize: CGSize(
                    width: width,
                    height: height
                )
            )
            
        case let .automatic(estimatedSize):
            
            var width = estimatedSize.width - paddingInsets.left - paddingInsets.right
            
            if width < 0.0 { width = 0.0 }
         
            contentComponent.contentMode = .automatic(
                estimatedSize: CGSize(
                    width: width,
                    height: estimatedSize.height
                )
            )
            
        }
        
        contentComponent.render()
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case let .automatic(estimatedSize):
            
            size = CGSize(
                width: estimatedSize.width,
                height: contentView.frame.height + paddingInsets.top + paddingInsets.bottom
            )
            
        }
        
        view.frame.size = size
        
        view.backgroundColor = contentView.backgroundColor
        
        view.addSubview(contentView)
        
        contentViewTopConstraint.constant = -paddingInsets.top
        
        contentViewLeadingConstraint.constant = -paddingInsets.left
        
        contentViewBottomConstraint.constant = paddingInsets.bottom
        
        contentViewTrailingConstraint.constant = paddingInsets.right
        
        contentViewWidthConstraint.constant = contentView.frame.width
        
        contentViewHeightConstraint.constant = contentView.frame.height
        
        NSLayoutConstraint.activate(contentViewConstraints)
        
    }
    
    // MARK: ViewRenderable
    
    public final let view: View 
    
    public final var preferredContentSize: CGSize { return view.bounds.size }
    
}

fileprivate extension UIBoxComponent {
    
    fileprivate final var contentView: UIView { return contentComponent.view }
    
}
