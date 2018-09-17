//
//  PostViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewController

import TinyCore
import TinyKit
import UIKit

public final class PostViewController: CollectionViewController<PostStorage, PostSectionCollection> {

    public final override func viewDidLoad() {
        
        super.viewDidLoad()
    
        reducer = { storage in
            
            return PostSectionCollection(
                sections: storage.pairs.map { pair in
                    
                    switch pair.value {
                        
                    case let .post(storage):
                        
                        let template = PostTemplate(
                            storage: storage,
                            elements: [
                                .title,
                                .body
                            ]
                        )
                        
                        template.configuration = PostTemplateConfiguration()
                    
                        template.registerView(
                            LargeTitleLabel.self,
                            binding: (from: \.title, to: \.text),
                            for: .title
                        )
                        
                        template.registerView(
                            TitleLabel.self,
                            binding: (from: \.title, to: \.text),
                            for: .title
                        )
                        
                        template.registerView(
                            BodyLabel.self,
                            binding: (from: \.body, to: \.text),
                            for: .body
                        )
                        
                        return .post(template)
                        
                    case let .comment(storage):
                        
                        let template = CommentTemplate(
                            storage: storage,
                            elements: [
                                .username,
                                .text
                            ]
                        )
                        
                        return .comment(template)
                        
                    }
                    
                }
            )
            
        }
        
    }

}
