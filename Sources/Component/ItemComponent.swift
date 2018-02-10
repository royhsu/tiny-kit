//
//  ItemComponent.swift
//  TinyKit
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ItemComponent

import TinyCore

public final class ItemComponent<
    V: View,
    M: Codable
>: Component {

    /// The underlying view that preserves the type information.
    internal final let itemView: V

    public final var model: M

    public typealias Binding = (V, M) -> Void

    private final let binding: Binding

    public init(
        contentMode: ComponentContentMode = .automatic,
        view: V,
        model: M,
        binding: @escaping Binding
    ) {

        self.contentMode = contentMode

        self.itemView = view

        self.model = model

        self.binding = binding

    }

    // MARK: ViewRenderable

    public final let view = View(frame: UIScreen.main.bounds)

    public final var preferredContentSize: CGSize { return view.bounds.size }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() {
        
        binding(
            itemView,
            model
        )

        itemView.removeFromSuperview()

        itemView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(itemView)

        NSLayoutConstraint.activate(
            [
                view
                    .leadingAnchor
                    .constraint(equalTo: self.itemView.leadingAnchor),
                view
                    .topAnchor
                    .constraint(equalTo: self.itemView.topAnchor),
                view
                    .trailingAnchor
                    .constraint(equalTo: self.itemView.trailingAnchor)
            ]
        )

        let size: CGSize

        switch contentMode {

        case .size(let width, let height):

            size = CGSize(
                width: width,
                height: height
            )

            // TODO: Should add constraints for the width and height?

        case .automatic:

            itemView.layoutIfNeeded()

            size = itemView.bounds.size

        }

        var frame = view.frame

        frame.size = size

        view.frame = frame

        itemView.frame = frame

        NSLayoutConstraint.activate(
            [
                view
                    .bottomAnchor
                    .constraint(equalTo: itemView.bottomAnchor)
            ]
        )

    }

}
