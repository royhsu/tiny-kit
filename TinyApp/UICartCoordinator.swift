//
//  UICartCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UICartCoordinator

import TinyKit
import TinyStore
import TinyUI

public final class UICartCoordinator: Coordinator {
    
    /// The navigator.
    private final let containerViewController: UIComponentViewController
    
    private final let cartBarComponent: UICartBarComponent
    
    public init() {
        
        let cartBarComponent = UICartBarComponent()
        
        self.cartBarComponent = cartBarComponent
        
        self.containerViewController = UIComponentViewController(component: cartBarComponent)
        
    }
    
    // MARK: Coordinator
    
    public final func activate() {
        
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

public extension UICartCoordinator {
    
    @discardableResult
    public final func setAmount(_ amount: Double) -> UICartCoordinator {
        
        cartBarComponent.setItem(
            UICartBarItem(amount: amount)
        )
        
        return self
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UICartCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return containerViewController }
    
}
