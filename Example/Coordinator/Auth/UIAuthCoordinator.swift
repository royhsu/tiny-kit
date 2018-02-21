//
//  UIAuthCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAuthCoordinator

import TinyKit

public final class UIAuthCoordinator: Coordinator {
    
    private final let window: UIWindow
    
    private final let navigationController: UINavigationController
    
    private final let authProvider: AuthProvider
    
    private final let signInComponent: UISignInComponent
    
    public init(
        frame: CGRect,
        authProvider: AuthProvider
    ) {
        
        self.authProvider = authProvider
        
        self.window = UIWindow(frame: frame)
        
        self.signInComponent = UISignInComponent(
            contentMode: .size(
                width: frame.width,
                height: frame.height
            )
        )
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: signInComponent)
        )
        
    }
    
    fileprivate final func authorize(with credentials: BasicCredentials) {
        
        authProvider.authorize(
            in: .background,
            credentials: credentials
        )
        .then(in: .main) { auth in print("\(auth)") }
        .catch(in: .main) { error in print("\(error)") }
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        signInComponent.delegate = self
        
        signInComponent.render()
        
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
        
    }
    
}

// MARK: - UISignInComponentDelegate

extension UIAuthCoordinator: UISignInComponentDelegate {
    
    public final func component(
        _ component: Component,
        didSupply credentials: BasicCredentials
    ) { authorize(with: credentials) }
    
}
