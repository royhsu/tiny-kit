//
//  UIProfileIntroductionComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIProfileIntroductionComponent

import TinyKit

public final class UIProfileIntroductionComponent: Component {

    /// The base component.
    private final let itemComponent: UIItemComponent<UIProfileIntroductionView>

    public init(
        contentMode: ComponentContentMode = .automatic(estimatedSize: .zero)
    ) {

        self.itemComponent = UIItemComponent(
            contentMode: contentMode,
            itemView: UIView.load(UIProfileIntroductionView.self)!
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

public extension UIProfileIntroductionComponent {

    public final func setIntroduction(_ introduction: UIProfileIntroduction?) {

        let itemView = itemComponent.itemView

        itemView.pictureImageView.image = introduction?.pictureImage

        itemView.nameLabel.text = introduction?.name

        itemView.introductionLabel.text = introduction?.introduction

    }

}
