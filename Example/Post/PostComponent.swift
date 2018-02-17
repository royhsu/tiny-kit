//
//  PostComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostComponent

import TinyKit

public final class PostComponent: Component {

    private typealias BaseComponent = ItemComponent<PostView>

    private final let baseComponent: BaseComponent

    public init(
        contentMode: ComponentContentMode = .automatic
    ) {

        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            itemView: UIView.load(PostView.self)!
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

public extension PostComponent {
    
    public final var title: String? {
        
        get { return baseComponent.itemView.titleLabel.text }
        
        set { baseComponent.itemView.titleLabel.text = newValue }
        
    }
    
    public final var content: String? {
        
        get { return baseComponent.itemView.contentLabel.text }
        
        set { baseComponent.itemView.contentLabel.text = newValue }
        
    }
    
}
