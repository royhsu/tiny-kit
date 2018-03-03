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
            
        case .automatic:
            
            // TODO: UIScreen is a hard dependency here. It's better to find alternative in the future.
            frame = UIScreen.main.bounds
            
        case .size(let width, let height):
            
            frame = CGRect(
                x: 0.0,
                y: 0.0,
                width: width,
                height: height
            )
            
        }
        
        self.view = View(frame: frame)

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {

        itemView.removeFromSuperview()

        itemView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(itemView)

        NSLayoutConstraint.activate(
            [
                view
                    .leadingAnchor
                    .constraint(equalTo: itemView.leadingAnchor),
                view
                    .topAnchor
                    .constraint(equalTo: itemView.topAnchor),
                view
                    .trailingAnchor
                    .constraint(equalTo: itemView.trailingAnchor)
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

            size = itemView.bounds.size

        }

        view.frame.size = size

        itemView.frame.size = size

        NSLayoutConstraint.activate(
            [
                view
                    .bottomAnchor
                    .constraint(equalTo: itemView.bottomAnchor)
            ]
        )
        
    }

    // MARK: ViewRenderable

    public final let view: View

    public final var preferredContentSize: CGSize { return view.bounds.size }

}
