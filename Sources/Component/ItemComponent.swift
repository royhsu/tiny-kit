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
        contentMode: ComponentContentMode,
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

    public final var preferredContentSize: CGSize { return itemView.bounds.size }

    // MARK: Component

    public final var contentMode: ComponentContentMode

    public final func render() -> Promise<Void> {

        return Promise(in: .main) { fulfill, _, _ in

            DispatchQueue.main.async {

                self.binding(
                    self.itemView,
                    self.model
                )

                self.itemView.removeFromSuperview()

                self.itemView.translatesAutoresizingMaskIntoConstraints = false

                self.view.addSubview(self.itemView)

                NSLayoutConstraint.activate(
                    [
                        self.view
                            .leadingAnchor
                            .constraint(equalTo: self.itemView.leadingAnchor),
                        self.view
                            .topAnchor
                            .constraint(equalTo: self.itemView.topAnchor),
                        self.view
                            .trailingAnchor
                            .constraint(equalTo: self.itemView.trailingAnchor)
                    ]
                )

                let size: CGSize

                switch self.contentMode {

                case .size(let width, let height):

                    size = CGSize(
                        width: width,
                        height: height
                    )

                    // TODO: Should add constraints for the width and height?

                case .automatic:

                    self.itemView.layoutIfNeeded()

                    size = self.itemView.bounds.size

                }

                var frame = self.view.frame

                frame.size = size

                self.view.frame = frame

                NSLayoutConstraint.activate(
                    [
                        self.view
                            .bottomAnchor
                            .constraint(equalTo: self.itemView.bottomAnchor)
                    ]
                )

                let result: Void = ()

                fulfill(result)

            }

        }

    }

}
