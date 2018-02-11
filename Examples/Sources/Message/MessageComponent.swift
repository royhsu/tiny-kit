//
//  MessageComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 09/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - MessageComponent

import TinyKit

public final class MessageComponent: Component {
    
    private typealias BaseComponent = ItemComponent<MessageView, Message>
    
    private final let baseComponent: BaseComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        message: Message = Message()
    ) {
        
        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            view: UIView.load(MessageView.self)!,
            model: message,
            binding: { messageView, message in
                
                messageView.textLabel.text = message.text
                
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
    
    public final func render() { baseComponent.render() }
    
}

public extension MessageComponent {
    
    public final var message: Message {
        
        get { return baseComponent.model }
        
        set { baseComponent.model = newValue }
        
    }
    
}
