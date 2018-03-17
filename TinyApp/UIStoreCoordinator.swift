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
    
    private final let cartBarComponent: UICartBarComponent
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
        self.cartBarComponent = UICartBarComponent()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
        collapseBarController.setBarViewController(
            UIComponentViewController(component: cartBarComponent)
        )
        
        // TODO: apply the theme.
        cartBarComponent.setActionButtonItem(
            UIPrimaryButtonItem(
                title: "Checkout",
                titleColor: .white,
                iconImage: #imageLiteral(resourceName: "icon-add").withRenderingMode(.alwaysTemplate),
                backgroundColor: UIColor(
                    red: 0.35,
                    green: 0.56,
                    blue: 0.87,
                    alpha: 1.0
                )
            )
        )
        
        cartBarComponent.render()
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UIStoreCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return collapseBarController }
    
}
