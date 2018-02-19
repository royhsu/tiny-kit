//
//  UILoadingComponent.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILoadingComponent

import TinyKit

public final class UILoadingComponent: Component {

    /// The base component.
    private final let itemComponent: UIItemComponent<UILoadingView>

    public init(contentMode: ComponentContentMode = .automatic) {

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(UILoadingView.self)!
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

public extension UILoadingComponent {

    public final func startAnimating() { itemComponent.itemView.activityIndicatorView.startAnimating() }

    public final func stopAnimating() { itemComponent.itemView.activityIndicatorView.stopAnimating() }

}
