//
//  AuthManager.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

extension User: Auth { }

// MARK: - AuthManager

import Hydra

public final class AuthManager: AuthProvider {
    
    public final func authorize(
        in context: Context,
        credentials: Credentails
    )
    -> Promise<Auth> {
    
        return Promise(in: context) { fulfill, _, _ in
            
            let user = User(name: "tinyworld")
            
            fulfill(user)
            
        }
        
    }
    
}
