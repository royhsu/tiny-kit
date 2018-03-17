//
//  UIStoreCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIStoreCoordinator

import TinyKit
import TinyStore
import TinyUI

public final class UIStoreCoordinator: Coordinator {
    
    /// The navigator.
    private final let collapseBarController: UICollapseBarController
    
    private final let cartCoordinator: UICartCoordinator
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartCoordinator = UICartCoordinator()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        collapseBarController.setBarViewController(cartCoordinator.viewController)
        
        cartCoordinator.activate()
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UIStoreCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return collapseBarController }
    
}
