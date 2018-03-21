//
//  UIHomeNavigationCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 18/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIHomeNavigationCoordinator

import TinyKit
import TinyStore

public final class UIHomeNavigationCoordinator: Coordinator {
    
    /// The navigator.
    private final let navigationController: UINavigationController
    
    private final let homeCoordinator: UIHomeCoordinator
    
    
    public init() {
        
        let homeCoordinator = UIHomeCoordinator()
        
        self.homeCoordinator = homeCoordinator
        
        self.navigationController = UINavigationController(rootViewController: homeCoordinator.viewController)
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        homeCoordinator
            .setShowProductDetail { [unowned self] viewController in
                
                self.navigationController.pushViewController(
                    viewController,
                    animated: true
                )
                
            }
            .activate()
    
    }
    
}

// MARK: - ViewControllerRepresentable

extension UIHomeNavigationCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
