//
//  UIApplicationCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIApplicationCoordinator

import TinyKit

public final class UIApplicationCoordinator: Coordinator {
    
    private final let window: UIWindow
    
    public typealias RootCoordinator = Coordinator & ViewControllerRepresentable
    
    private final var rootCoordinator: RootCoordinator
    
    public init(contentSize: CGSize) {
        
        self.window = UIWindow(
            frame: CGRect(
                origin: .zero,
                size: contentSize
            )
        )
        
        let authCoordinator = UIAuthCoordinator(
            contentSize: contentSize,
            authProvider: AuthManager()
        )
        
        self.rootCoordinator = authCoordinator
        
        authCoordinator.delegate = self
        
    }
    
    public final func activate() {
        
        window.rootViewController = rootCoordinator.viewController
        
        window.makeKeyAndVisible()
        
        rootCoordinator.activate()
        
    }
    
}

// MARK: - UIAuthCoordinatorDelegate

extension UIApplicationCoordinator: UIAuthCoordinatorDelegate {
    
    public final func coordinate(
        _ coordinate: Coordinator,
        didGrant auth: Auth
    ) {
        
        let profileCoordinator = UIProfileCoordinator(
            contentSize: window.bounds.size,
            userId: "1",
            userManager: UserManager(),
            postManager: PostManager()
        )
        
        window.rootViewController = profileCoordinator.viewController
        
        profileCoordinator.activate()
        
        rootCoordinator = profileCoordinator
        
    }
    
}
