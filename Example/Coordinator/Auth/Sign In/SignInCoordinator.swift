//
//  SignInCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAuthCoordinator

import TinyKit

public final class UIAuthCoordinator {
    
    public final let window = UIWindow(frame: UIScreen.main.bounds)
    
    public final let navigationController: UINavigationController
    
    private final let authProvider: AuthProvider
    
    private final let signInComponent: UISignInComponent
    
    public init(
        contentSize: CGSize,
        authProvider: AuthProvider
    ) {
        
        self.authProvider = authProvider
        
        self.signInComponent = UISignInComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
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
