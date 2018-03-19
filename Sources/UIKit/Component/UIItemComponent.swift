//
//  UIItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 16/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIItemComponent

public final class UIItemComponent<ItemView: UIView>: Component {

    public final let itemView: ItemView

    public init(
        contentMode: ComponentContentMode = .automatic,
        itemView: ItemView
    ) {

        self.contentMode = contentMode

        self.itemView = itemView
        
        let frame: CGRect
        
        switch contentMode {
            
        case let .size(width, height):
            
            frame = CGRect(
                x: 0.0,
                y: 0.0,
                width: width,
                height: height
            )
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            frame = UIScreen.main.bounds
            
        }
        
        let view = View(frame: frame)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view = view

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        itemView.removeFromSuperview()

        itemView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(itemView)
        
        let trailingConstraint = view.trailingAnchor.constraint(equalTo: itemView.trailingAnchor)
        
        // Reference: https://stackoverflow.com/questions/26652854/ios8-cell-constraints-break-when-adding-disclosure-indicator
        trailingConstraint.priority = UILayoutPriority(800.0)

        NSLayoutConstraint.activate(
            [
                view.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
                view.topAnchor.constraint(equalTo: itemView.topAnchor),
                trailingConstraint
            ]
        )

        let size: CGSize

        switch contentMode {

        case .size(let width, let height):

            size = CGSize(
                width: width,
                height: height
            )
    
            NSLayoutConstraint.activate(
                [
                    itemView.widthAnchor.constraint(equalToConstant: width),
                    itemView.heightAnchor.constraint(equalToConstant: height)
                ]
            )
            
        case .automatic:
            
            itemView.layoutIfNeeded()

            size = itemView.bounds.size

        }

        view.frame.size = size
        
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: itemView.bottomAnchor)

        // Reference: https://stackoverflow.com/questions/26652854/ios8-cell-constraints-break-when-adding-disclosure-indicator
        bottomConstraint.priority = UILayoutPriority(800.0)
        
        NSLayoutConstraint.activate(
            [
                bottomConstraint
            ]
        )
        
    }

    // MARK: ViewRenderable

    public final let view: View

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
