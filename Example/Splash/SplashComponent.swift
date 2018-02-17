//
//  SplashComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 11/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SplashComponent

import TinyKit

public final class SplashComponent: Component {

    private typealias BaseComponent = ItemComponent<View>

    private final let baseComponent: BaseComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        splashView: View = UIView()
    ) {

        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            itemView: splashView
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
