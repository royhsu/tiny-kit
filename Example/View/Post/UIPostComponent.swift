//
//  UIPostComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIPostComponent

import TinyKit

public final class UIPostComponent: Component {

    /// The base component.
    private final let itemComponent: UIItemComponent<UIPostView>

    public init(contentMode: ComponentContentMode = .automatic) {

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(UIPostView.self)!
        )

    }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return itemComponent.contentMode }

        set { itemComponent.contentMode = newValue }

    }

    public final func render() { itemComponent.render() }

    // MARK: ViewRenderable

    public final var view: View { return itemComponent.view }

    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }

}

public extension UIPostComponent {

    public final func setPost(_ post: UIPost?) {

        let itemView = itemComponent.itemView

        itemView.titleLabel.text = post?.title

        itemView.contentLabel.text = post?.content

    }

}
