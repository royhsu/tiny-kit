//
//  PostComponent.swift
//  TinyKitExamples
//
//  Created by Roy Hsu on 08/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Post

import TinyCore
import TinyKit

public final class PostComponent: ItemComponent<PostView, Post> {
    
    public init(
        title: String,
        content: String
    ) {

        super.init(
            view: UIView.load(PostView.self)!,
            model: Post(
                title: title,
                content: content
            ),
            binding: { postView, post in

                postView.titleLabel.text = post.title

                postView.contentLabel.text = post.content

            }
        )

    }
    
}
