//
//  ProfileHeaderComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ProfileHeaderComponent

import Hydra
import TinyCore
import TinyKit

public final class ProfileHeaderComponent: Component {

    private final let introductionComponent = ProfileIntroductionComponent()

    private final let baseComponent: ListComponent

    public init(contentMode: ComponentContentMode = .automatic) {

        self.baseComponent = ListComponent(contentMode: contentMode)

    }

    // MARK: ViewRenderable

    public final var view: View { return baseComponent.view }

    public final var preferredContentSize: CGSize { return baseComponent.preferredContentSize }

    // MARK: Component

    public final var contentMode: ComponentContentMode {

        get { return baseComponent.contentMode }

        set { baseComponent.contentMode = newValue }

    }

    public final func render() {

        let components: [Component] = [ introductionComponent ]

        baseComponent.itemComponents = AnyCollection(components)

        baseComponent.render()

    }

}

public extension ProfileHeaderComponent {

    public final var pictureImage: UIImage? {

        get { return introductionComponent.pictureImage }

        set { introductionComponent.pictureImage = newValue }

    }

    public final var name: String? {

        get { return introductionComponent.name }

        set { introductionComponent.name = newValue }

    }

    public final var introduction: String? {

        get { return introductionComponent.introduction }

        set { introductionComponent.introduction = newValue }

    }

}
