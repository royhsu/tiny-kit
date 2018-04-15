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

    public init(
        contentMode: ComponentContentMode = .automatic,
        itemView: ItemView
    ) {

        self.contentMode = contentMode

        self.itemView = itemView
        
        let frame: CGRect

        switch contentMode {

        case let .size(size):

            frame = CGRect(
                origin: .zero,
                size: size
            )

        case .automatic:

            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            frame = UIScreen.main.bounds

        }

        self.view = View(frame: frame)

    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        // TODO: sync background doesn't work.
//        view.backgroundColor = itemView.backgroundColor
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        // TODO: sync background doesn't work.
//        view.backgroundColor = itemView.backgroundColor
        
        itemView.removeFromSuperview()

        itemView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(itemView)

        let trailingConstraint = view.trailingAnchor.constraint(equalTo: itemView.trailingAnchor)

        trailingConstraint.priority = UILayoutPriority(900.0)

        NSLayoutConstraint.activate(
            [
                view.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
                view.topAnchor.constraint(equalTo: itemView.topAnchor),
                trailingConstraint
            ]
        )
        
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: itemView.bottomAnchor)
        
        bottomConstraint.priority = UILayoutPriority(900.0)

        let size: CGSize

        switch contentMode {

        case let .size(value):

            size = value

            let widthConstraint = itemView.widthAnchor.constraint(equalToConstant: size.width)
            
            widthConstraint.priority = UILayoutPriority(750.0)
            
            let heightConstraint = itemView.heightAnchor.constraint(equalToConstant: size.height)
            
            heightConstraint.priority = UILayoutPriority(750.0)
            
            NSLayoutConstraint.activate(
                [
                    widthConstraint,
                    heightConstraint
                ]
            )

        case .automatic:
            
            itemView.layoutIfNeeded()

            size = itemView.bounds.size
            
            
        }

        itemView.frame.size = size

        view.frame.size = size
        
        NSLayoutConstraint.activate(
            [ bottomConstraint ]
        )

    }

    // MARK: ViewRenderable

    public final let view: View

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
