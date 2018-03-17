//
//  UIHomeCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIHomeCoordinator

import TinyKit

public final class UIHomeCoordinator: Coordinator {
    
    /// The navigator.
    private final let collapseBarController: UICollapseBarController
    
    private final let cartCoordinator: UICartCoordinator
    
    private final let storeCoordinator: UIStoreCoordinator
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartCoordinator = UICartCoordinator()
        
        self.storeCoordinator = UIStoreCoordinator()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        collapseBarController.setBarViewController(cartCoordinator.viewController)
        
        collapseBarController.setBackgroundViewController(storeCoordinator.viewController)
        
        cartCoordinator.activate()
        
        storeCoordinator.activate()
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UIHomeCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return collapseBarController }
    
}
