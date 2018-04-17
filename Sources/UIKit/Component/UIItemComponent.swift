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

    public init(
        contentMode: ComponentContentMode = .automatic2(estimatedSize: .zero),
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
        
        itemViewBottomConstraint.priority = UILayoutPriority(900.0)
        
        itemViewTrailingConstraint.priority = UILayoutPriority(900.0)
        
        itemViewWidthConstraint.priority = UILayoutPriority(750.0)
        
        itemViewHeightConstraint.priority = UILayoutPriority(750.0)
        
        view.backgroundColor = itemView.backgroundColor
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            size = UIScreen.main.bounds.size
            
        case let .automatic2(estimatedSize): size = estimatedSize
            
        }
        
        view.frame.size = size
        
        itemView.frame.size = view.frame.size
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        let itemViewConstraints = [
            itemViewTopConstraint,
            itemViewLeadingConstraint,
            itemViewBottomConstraint,
            itemViewTrailingConstraint,
            itemViewWidthConstraint,
            itemViewHeightConstraint
        ]
        
        view.backgroundColor = itemView.backgroundColor
        
        itemView.removeFromSuperview()

        itemView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.deactivate(itemViewConstraints)
        
        view.addSubview(itemView)

        let size: CGSize

        switch contentMode {

        case let .size(value): size = value

        case .automatic:
            
            itemView.layoutIfNeeded()

            size = itemView.bounds.size
            
        case let .automatic2(estimatedSize): size = itemView.sizeThatFits(estimatedSize)
            
        }

        view.frame.size = size
        
        itemView.frame.size = view.frame.size
        
        itemViewWidthConstraint.constant = itemView.frame.size.width
        
        itemViewWidthConstraint.constant = itemView.frame.size.height
        
        NSLayoutConstraint.activate(itemViewConstraints)

    }

    // MARK: ViewRenderable

    /// The view synchronizes its background color with the item view.
    /// Please make sure to specify the background color on the item view instead of this view.
    public final let view: View

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
