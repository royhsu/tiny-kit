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
    
        storageReducer = { [unowned self] storage in
            
            return FeedSectionCollection(
                sections: storage.elements.map { pair in

                    switch pair.value {

                    case let .post(storage):

                        let template = PostTemplate(
                            storage: storage,
                            actionDispatcher: self.actionDispatcher,
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
                            binding: { storage, button in button.storage = storage },
                            for: .like
                        )

                        return .post(template)

                    case let .comment(storage):

//                        let template = CommentTemplate(
//                            storage: storage,
//                            actionDispatcher: self.actionDispatcher,
//                            errorHandler: self.errorHandler,
//                            elements: [
//                                .username,
//                                .text
//                            ]
//                        )
                        
                        let layout = CarouselViewLayout()
                        
                        layout.directionalContentInsets = .init(
                            top: 10.0,
                            leading: 10.0,
                            bottom: 10.0,
                            trailing: 10.0
                        )
                        
                        layout.interitemSpacing = 10.0
                        
                        layout.showsScrollIndicator = false
                        
                        layout.setWidthForItem { _, layoutFrame, _ in layoutFrame.width }
                        
                        let template = AnswerTemplate(
                            storage: storage,
                            layout: layout,
                            actionDispatcher: self.actionDispatcher,
                            elements: [
                                .content,
                                .separator
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

public struct TestError: Error { public init() { } }

extension FeedViewController: ActionDispatcher {
    
    public final func dispatch(action: Action) {
        
        if let action = action as? LikeButtonAction {
            
            switch action {
                
            case let .liked(storage):
                
//                print("isLiked:", storage)
//
//                navigate(to: .red)
                
                errors.value = TestError()
                
            }
            
            return
            
        }
        
    }

}
