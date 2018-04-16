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
        
        self.view = View()
        
        self.prepare()

    }
    
    // MARK: Set Up
    
    fileprivate final func prepare() {
        
        // TODO: sync background doesn't work.
//        view.backgroundColor = itemView.backgroundColor
        
        let size: CGSize
        
        switch contentMode {
            
        case let .size(value): size = value
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            size = UIScreen.main.bounds.size
            
        case let .automatic2(estimatedSize): size = estimatedSize
            
        }
        
        view.frame.size = size
        
        itemView.frame.size = size
        
    }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        // TODO: sync background doesn't work.
//        view.backgroundColor = itemView.backgroundColor
        
        itemView.removeFromSuperview()

        itemView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.deactivate(itemView.constraints)
        
        view.addSubview(itemView)

//        let trailingConstraint = view.trailingAnchor.constraint(equalTo: itemView.trailingAnchor)
//
//        trailingConstraint.priority = UILayoutPriority(900.0)
//
//        NSLayoutConstraint.activate(
//            [
//                view.topAnchor.constraint(equalTo: itemView.topAnchor),
//                view.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
//                trailingConstraint
//            ]
//        )

        let size: CGSize

        switch contentMode {

        case let .size(value): size = value

        case .automatic:
            
            itemView.layoutIfNeeded()

            size = itemView.bounds.size
            
        case let .automatic2(estimatedSize):
            
//            view.frame.size = estimatedSize
//
//            itemView.frame.size = estimatedSize
            
//            print("before", view.frame.size, itemView.frame.size)
//
//            itemView.layoutIfNeeded()
//
//            itemView.sizeToFit()
//
//            print("after", view.frame.size, itemView.frame.size)
            
//            size = itemView.frame.size
            
            size = itemView.sizeThatFits(estimatedSize)
            
        }

        itemView.frame.size = size

        view.frame.size = size

        let trailingConstraint = view.trailingAnchor.constraint(equalTo: itemView.trailingAnchor)

        trailingConstraint.priority = UILayoutPriority(900.0)

        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: itemView.topAnchor),
                view.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
                trailingConstraint
            ]
        )
        
        let widthConstraint = itemView.widthAnchor.constraint(equalToConstant: size.width)

        widthConstraint.priority = UILayoutPriority(750.0)

        let heightConstraint = itemView.heightAnchor.constraint(equalToConstant: size.height)

        heightConstraint.priority = UILayoutPriority(750.0)
        
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: itemView.bottomAnchor)
        
        bottomConstraint.priority = UILayoutPriority(900.0)
        
        NSLayoutConstraint.activate(
            [
                widthConstraint,
                heightConstraint
            ]
        )
        
        NSLayoutConstraint.activate(
            [ bottomConstraint ]
        )

    }

    // MARK: ViewRenderable

    public final let view: View

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
