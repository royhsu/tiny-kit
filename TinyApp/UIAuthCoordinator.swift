//
//  UIAuthCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 28/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIAuthCoordinator

import TinyLanding

public final class UIAuthCoordinator: AuthCoordinator {
    
    /// The base coordinator.
    private final let landingCoordinator: UILandingCoordinator
    
    private final var authHandler: AuthHandler?
    
    private final let authManager: AuthManager
    
    public init(contentSize: CGSize) {
        
        self.landingCoordinator = UILandingCoordinator(contentSize: contentSize)
        
        self.authManager = AuthManager()
        
    }
    
    // MARK: AuthCoordinator
    
    public typealias Auth = AccessToken
    
    @discardableResult
    public final func onGrant(handler: AuthHandler?) -> Self {
        
        authHandler = handler
        
        return self
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        landingCoordinator
            .onSupply { [weak self] supply in
                
                guard
                    let weakSelf = self
                else { return }
                
                switch supply {
                    
                case .basic(let username, let password):
                    
                    weakSelf.authManager.authorize(
                        in: .background,
                        username: username,
                        password: password
                    )
                    .then(in: .main) { accessToken in
                        
                        weakSelf.authHandler?(accessToken)
                        
                    }
                    .catch(in: .main) { error in
                        
                        print("\(error)")
                        
                    }
                    
                }
                
            }
            .activate()
        
    }
    
    // MARK: ViewControllerRepresentable
    
    public final var viewController: ViewController { return landingCoordinator.viewController }
    
}
