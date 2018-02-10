//
//  EmojiComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 10/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - EmojiComponent

import TinyCore
import TinyKit

public final class EmojiComponent: Component {

    private typealias BaseComponent = ItemComponent<UILabel, Emoji>

    private final let baseComponent: BaseComponent

    public init(
        contentMode: ComponentContentMode = .automatic,
        emoji: Emoji = Emoji()
    ) {

        let emojiLabel = UILabel()

        emojiLabel.textAlignment = .center

        emojiLabel.font = .systemFont(ofSize: 30.0)

        emojiLabel.numberOfLines = 0

        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            view: emojiLabel,
            model: emoji,
            binding: { emojiLabel, emoji in

                emojiLabel.text = emoji.text

            }
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

    public final func render() -> Promise<Void> { return baseComponent.render() }

}

public extension EmojiComponent {

    public final var emoji: Emoji {

        get { return baseComponent.model }

        set { baseComponent.model = newValue }

    }

}
