//
//  LoadingComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - LoadingComponent

import TinyKit

public final class LoadingComponent: Component {

    private typealias BaseComponent = ItemComponent<LoadingView>

    private final let baseComponent: BaseComponent

    public init(
        contentMode: ComponentContentMode = .automatic
    ) {

        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            itemView: UIView.load(LoadingView.self)!
        )

    }

    // MARK: ViewRenderable

    public final var view: View { return baseComponent.view }

    public final var preferredContentSize: CGSize { return baseComponent.preferredContentSize }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return baseComponent.contentMode }

        set { baseComponent.contentMode = newValue }

    }

    public final func render() { baseComponent.render() }

}

public extension LoadingComponent {

    public final func startAnimating() { baseComponent.itemView.activityIndicatorView.startAnimating() }

    public final func stopAnimating() { baseComponent.itemView.activityIndicatorView.stopAnimating() }

}
