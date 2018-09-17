//
//  PostActionDispatcher.swift
//  Examples
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - PostActionDispatcher

import TinyKit

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
