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

public enum LikeButtonAction: Action {
    
    case liked(Bool)
    
}

public final class PostActionDispatcher: ActionDispatcher {
    
    public func dispatch(action: Action) {
    
        if let action = action as? LikeButtonAction {

            switch action {
                
            case let .liked(isLiked): print("isLiked:", isLiked)
                
            }
            
            return
            
        }
        
    }
    
}

public final class LikeButton: UIButton, Actionable {
    
    public final var dispatcher: ActionDispatcher?
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        prepare()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        prepare()
        
    }
    
    private final func prepare() {
        
        addTarget(
            self,
            action: #selector(like),
            for: .valueChanged
        )
        
        setTitle(
            "Like",
            for: .normal
        )
        
        setTitle(
            "Liked",
            for: .selected
        )
        
    }
    
    @objc
    public final func like(_ sender: Any) {
        
        isSelected.toggle()
        
        let action: LikeButtonAction = .liked(isSelected)
        
        dispatcher?.dispatch(action: action)
        
    }
    
}

public final class PostViewController: CollectionViewController<PostStorage, PostSectionCollection> {
    
    public final let dispatcher = PostActionDispatcher()
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
    
        reducer = { storage in
            
            return PostSectionCollection(
                sections: storage.pairs.map { pair in
                    
                    switch pair.value {
                        
                    case let .post(storage):
                        
                        let template = PostTemplate(
                            storage: storage,
                            dispatcher: self.dispatcher,
                            elements: [
                                .title,
                                .body,
                                .like
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
                        
                        template.registerView(
                            LikeButton.self,
                            binding: (from: \.isLiked, to: \.isSelected),
                            for: .like
                        )
                        
                        return .post(template)
                        
                    case let .comment(storage):
                        
                        let template = CommentTemplate(
                            storage: storage,
                            dispatcher: self.dispatcher,
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
