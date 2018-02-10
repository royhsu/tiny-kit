//
//  PostComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostComponent

import TinyCore
import TinyKit

public final class PostComponent: Component {
    
    private typealias BaseComponent = ItemComponent<PostView, Post>
    
    private final let baseComponent: BaseComponent
    
    public init(
        contentMode: ComponentContentMode = .automatic,
        post: Post = Post()
    ) {
        
        self.baseComponent = BaseComponent(
            contentMode: contentMode,
            view: UIView.load(PostView.self)!,
            model: post,
            binding: { postView, post in
                
                postView.titleLabel.text = post.title

                postView.contentLabel.text = post.content
                
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

public extension PostComponent {
    
    public final var post: Post {
        
        get { return baseComponent.model }
        
        set { baseComponent.model = newValue }
        
    }
    
}
