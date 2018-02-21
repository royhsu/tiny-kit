//
//  AuthProvider.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - AuthProvider

import Hydra

public protocol AuthProvider {
    
    func authorize(
        in context: Context,
        credentials: Credentails
    )
    -> Promise<Auth>
    
}
