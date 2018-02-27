//
//  BasicAuthManager.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - BasicAuthManager

import Hydra

public final class BasicAuthManager {
    
    private final let email: String
    
    private final let password: String
    
    public init(
        email: String,
        password: String
    ) {
        
        self.email = email
        
        self.password = password
        
    }
    
    public final func authorize(in context: Context) -> Promise<Auth> {
    
        return Promise(in: context) { fulfill, _, _ in
            
            fulfill(
                Auth(
                    accessToken: AccessToken(value: "token")
                )
            )
            
        }
        
    }
    
}
