//
//  ProfileIntroductionComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileIntroductionComponent

import TinyKit

public final class ProfileIntroductionComponent: Component {

    private typealias BaseComponent = ItemComponent<ProfileIntroductionView>

    private final let baseComponent: BaseComponent

    public init(
        contentMode: ComponentContentMode = .automatic
    ) {

        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            itemView: UIView.load(ProfileIntroductionView.self)!
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
