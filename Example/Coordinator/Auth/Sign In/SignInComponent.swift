//
//  SignInComponent.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - SignInComponentDelegate

import TinyKit

public protocol SignInComponentDelegate: class {
    
    func component(
        _ component: Component,
        didSupply credentials: BasicCredentials
    )
    
}

// MARK: - SignInComponent

public protocol SignInComponent: class {
    
    var delegate: SignInComponentDelegate? { get set }
    
}
