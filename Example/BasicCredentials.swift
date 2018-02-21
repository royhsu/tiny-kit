//
//  BasicCredentials.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - BasicCredentials

public struct BasicCredentials: Credentails {
    
    public let username: String
    
    public let password: String
    
    public init(username: String, password: String) {
        
        self.username = username
        
        self.password = password
        
    }
    
}
