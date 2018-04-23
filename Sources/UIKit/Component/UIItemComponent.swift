//
//  UIItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 16/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIItemComponent

// Reference: https://stackoverflow.com/questions/26652854/ios8-cell-constraints-break-when-adding-disclosure-indicator
public final class UIItemComponent<ItemView: UIView>: Component {

    public final let itemView: ItemView
    
    private final let itemViewTopConstraint: NSLayoutConstraint
    
    private final let itemViewLeadingConstraint: NSLayoutConstraint
    
    private final let itemViewBottomConstraint: NSLayoutConstraint
    
    private final let itemViewTrailingConstraint: NSLayoutConstraint
    
    private final let itemViewWidthConstraint: NSLayoutConstraint
    
    private final let itemViewHeightConstraint: NSLayoutConstraint
    
    /// - Parameters:
    ///   - contentMode: Make sure to assign a non-zero estimated size for rendering correctly based on the item content if set to .automatic. The default is set to .automatic with zero value of estimated size.
    ///   - itemView: The item view to wrap with.
    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero),
        itemView: ItemView
    ) {

        self.contentMode = contentMode

        self.itemView = itemView
        
        self.view = View()
        
        self.itemViewTopConstraint = view.topAnchor.constraint(equalTo: itemView.topAnchor)
        
        self.itemViewLeadingConstraint = view.leadingAnchor.constraint(equalTo: itemView.leadingAnchor)
        
        self.itemViewBottomConstraint = view.bottomAnchor.constraint(equalTo: itemView.bottomAnchor)
        
        self.itemViewTrailingConstraint = view.trailingAnchor.constraint(equalTo: itemView.trailingAnchor)
        
        self.itemViewWidthConstraint = itemView.widthAnchor.constraint(equalToConstant: itemView.frame.width)
        
        self.itemViewHeightConstraint = itemView.heightAnchor.constraint(equalToConstant: itemView.frame.size.height)
        
        self.prepare()

    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        prepareLayout()
        
        view.backgroundColor = itemView.backgroundColor
        
    }
    
    fileprivate final func prepareLayout() {
        
        itemViewBottomConstraint.priority = UILayoutPriority(900.0)
        
        itemViewTrailingConstraint.priority = UILayoutPriority(900.0)
        
        itemViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        itemViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        view.frame.size = contentMode.initialSize
        
        itemView.frame = CGRect(
            origin: .zero,
            size: view.frame.size
        )
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {
        
        renderLayout()
        
        view.backgroundColor = itemView.backgroundColor

    }
    
    fileprivate final func renderLayout() {
        
        itemView.removeFromSuperview()
        
        itemView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.deactivate(
            [
                itemViewTopConstraint,
                itemViewLeadingConstraint,
                itemViewBottomConstraint,
                itemViewTrailingConstraint,
                itemViewWidthConstraint,
                itemViewHeightConstraint
            ]
        )
        
        view.addSubview(itemView)
        
        switch contentMode {
            
        case let .size(size):
            
            view.frame.size = size
            
            itemView.frame.size = view.frame.size
            
            itemViewWidthConstraint.constant = itemView.frame.width
            
            itemViewHeightConstraint.constant = itemView.frame.height
            
            NSLayoutConstraint.activate(
                [
                    itemViewTopConstraint,
                    itemViewLeadingConstraint,
                    itemViewTrailingConstraint,
                    itemViewWidthConstraint,
                    itemViewHeightConstraint
                ]
            )
            
            itemView.layoutIfNeeded()
            
            itemView.frame.origin = .zero
            
            view.frame.size = itemView.frame.size
            
            NSLayoutConstraint.activate(
                [ itemViewBottomConstraint ]
            )
            
        case let .automatic(estimatedSize):
            
            view.frame.size = estimatedSize
            
            itemView.frame.size = view.frame.size
            
            NSLayoutConstraint.activate(
                [
                    itemViewTopConstraint,
                    itemViewLeadingConstraint,
                    itemViewTrailingConstraint
                ]
            )
            
            itemView.layoutIfNeeded()
            
            // Avoid the item view rendering 0.0 width without a width constraint.
            if
                itemView.frame.width == 0.0
                && estimatedSize.width >= 0.0 {
                
                itemView.frame.size.width = estimatedSize.width
                
            }
            
            // Avoid the item view rendering 0.0 height without a height constraint.
            if
                itemView.frame.height == 0.0
                && estimatedSize.height >= 0.0 {
                
                itemView.frame.size.height = estimatedSize.height
                
            }
            
            itemView.frame.origin = .zero
            
            view.frame.size = itemView.frame.size
            
            itemViewWidthConstraint.constant = itemView.frame.width
            
            itemViewHeightConstraint.constant = itemView.frame.height
            
            NSLayoutConstraint.activate(
                [
                    itemViewBottomConstraint,
                    itemViewWidthConstraint,
                    itemViewHeightConstraint
                ]
            )
            
        }
        
    }

    // MARK: ViewRenderable

    /// The view synchronizes its background color with the item view.
    /// Please make sure to specify the background color on the item view instead of this view.
    public final let view: View

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
