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
    
    public final var emoji: Emoji {
        
        get { return itemComponent.model }

        set { itemComponent.model = newValue }
        
    }
    
    private final let itemComponent: ItemComponent<UILabel, Emoji>
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        emoji: Emoji = Emoji()
    ) {
        
        let emojiLabel = UILabel()
        
        emojiLabel.textAlignment = .center
        
        emojiLabel.font = .systemFont(ofSize: 30.0)
        
        emojiLabel.numberOfLines = 0
    
        self.itemComponent = ItemComponent(
            contentMode: contentMode,
            view: emojiLabel,
            model: emoji,
            binding: { emojiLabel, emoji in
                
                emojiLabel.text = emoji.text
                
            }
        )
        
    }
    
    // MARK: ViewRenderable
    
    public final var view: View { return itemComponent.view }
    
    public final var preferredContentSize: CGSize { return itemComponent.preferredContentSize }
    
    // MARK: Component
    
    public final var contentMode: ComponentContentMode {
        
        get { return itemComponent.contentMode }
        
        set { itemComponent.contentMode = newValue }
        
    }
    
    public final func render() -> Promise<Void> { return itemComponent.render() }
    
}
