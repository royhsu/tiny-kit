//
//  UIMessageComponent.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 20/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIMessageComponent

import TinyKit

public final class UIMessageComponent: Component {

    /// The base component.
    private final let itemComponent: UIItemComponent<UIMessageView>

    public init(contentMode: ComponentContentMode = .automatic) {

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(UIMessageView.self)!
        )

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() { return itemComponent.render() }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

}

public extension UIMessageComponent {

    public final func setMessage(_ message: UIMessage?) {

        itemComponent.itemView.titleLabel.text = message?.title

        itemComponent.itemView.textLabel.text = message?.text

    }

}
