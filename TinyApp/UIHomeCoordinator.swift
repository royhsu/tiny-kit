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
    
    private final let cartContentComponent: UIListComponent
    
    private final let storeCoordinator: UIStoreCoordinator
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartCoordinator = UICartCoordinator()
        
        self.cartContentComponent = UIListComponent()
        
        self.storeCoordinator = UIStoreCoordinator()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        collapseBarController.setBarContentViewController(
            UIComponentViewController(component: cartContentComponent)
        )
        
        collapseBarController.setBarViewController(cartCoordinator.viewController)
        
        collapseBarController.setBackgroundViewController(storeCoordinator.viewController)
        
        cartCoordinator.activate()
        
        storeCoordinator.activate()
        
    }
    
}

public extension UIHomeCoordinator {
    
    public typealias DidSelectProductHandler = UIStoreCoordinator.DidSelectProductHandler
    
    @discardableResult
    public final func setDidSelectProduct(_ handler: DidSelectProductHandler?) -> UIHomeCoordinator {
        
        storeCoordinator.setDidSelectProduct(handler)
        
        return self
        
    }
    
    public typealias NumberOfCartDescriptorsHandler = () -> Void
    
    @discardableResult
    public final func setNumberOfCartDescriptors(_ handler: NumberOfCartDescriptorsHandler?) -> UIHomeCoordinator {
        
        // TODO: feed to list.
        
        return self
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UIHomeCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return collapseBarController }
    
}
