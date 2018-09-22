//
//  FeedViewController.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/16.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - FeedViewController

import TinyCore
import TinyKit
import TinyStorage

public final class FeedViewController<S>: CollectionViewController<S, FeedSectionCollection, PrefetchingFeedSectionColleciton>
where
    S: Storage,
    S.Value == Feed {
    
    public final override func viewDidLoad() {
        
        super.viewDidLoad()
        
        actionDispatcher = self

        errorHandler = self
    
        storageReducer = { storage in
            
            return FeedSectionCollection(
                sections: storage.elements.map { pair in

                    switch pair.value {

                    case let .post(storage):

                        let template = PostTemplate(
                            storage: storage,
                            actionDispatcher: self.actionDispatcher,
                            errorHandler: self.errorHandler,
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
                            from: .main,
                            binding: (from: \.isLiked, to: \.isSelected),
                            for: .like
                        )

                        return .post(template)

                    case let .comment(storage):

                        let template = CommentTemplate(
                            storage: storage,
                            actionDispatcher: self.actionDispatcher,
                            errorHandler: self.errorHandler,
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

// MARK: - Navigation

extension FeedViewController: Navigation {
    
    public enum Destination {
        
        case red
        
    }
    
    public final func navigate(to destionation: Destination) {
        
        switch destionation {
            
        case .red:
            
            let viewController = ViewController()
            
            viewController.view.backgroundColor = .red
            
            show(
                viewController,
                sender: self
            )
            
        }
        
    }
    
}

// MARK: - ActionDispatcher

extension FeedViewController: ActionDispatcher {
    
    public final func dispatch(action: Action) {
        
        if let action = action as? LikeButtonAction {
            
            switch action {
                
            case let .liked(isLiked):
                
                print("isLiked:", isLiked)
                
                navigate(to: .red)
                
            }
            
            return
            
        }
        
    }

}

// MARK: - FeedViewController

extension FeedViewController: ErrorHandler {
    
    public func `catch`(error: Error) { print("error: \(error)") }
    
}
