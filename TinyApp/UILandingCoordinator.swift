//
//  UILandingCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILandingCoordinator

import TinyAuth
import TinyLanding

public final class UILandingCoordinator: Coordinator {
    
    /// The navigator.
    private final let navigationController: UINavigationController
    
    private final let landingComponent: UILandingComponent
    
    private final var supplyHandler: UILandingSupplyHandler?
    
    public init(contentSize: CGSize) {
        
        let landingComponent = UILandingComponent(
            contentMode: .size(contentSize),
            listComponent: UIListComponent()
        )
        
        self.landingComponent = landingComponent
        
        self.navigationController = UINavigationController(
            rootViewController: UIComponentViewController(component: landingComponent)
        )
        
    }
    
    public final func activate() {
        
        landingComponent
            .setLogo(
                UILandingLogo(
                    logoImage: #imageLiteral(resourceName: "icon-logo"),
                    backgroundImage: #imageLiteral(resourceName: "image-landing-logo-background")
                )
            )
//            .addButton(
//                with: UIPrimaryButtonItem(
//                    title: NSLocalizedString(
//                        "Sign Up",
//                        comment: ""
//                    ),
//                    titleColor: .white,
//                    backgroundColor: .red
//                ),
//                action: { print("Go sign up!") }
//            )
//            .addButton(
//                with: UIPrimaryButtonItem(
//                    title: NSLocalizedString(
//                        "Sign In",
//                        comment: ""
//                    ),
//                    titleColor: .white,
//                    backgroundColor: .black
//                ),
//                action: signIn
//            )
            .render()
        
    }
    
    fileprivate final func signIn() {
        
        let signInComponent = UISignInComponent(
            listComponent: UIListComponent()
        )
        .onSubmit { [weak self] email, password in
            
            self?.supplyHandler?(
                .basic(
                    username: email,
                    password: password
                )
            )
            
        }
        
        let viewController = UIComponentViewController(component: signInComponent)
        
        signInComponent.render()
        
        navigationController.pushViewController(
            viewController,
            animated: true
        )
        
    }
    
}

public extension UILandingCoordinator {
    
    public final func onSupply(handler: UILandingSupplyHandler? = nil) -> UILandingCoordinator {
        
        supplyHandler = handler
        
        return self
            
    }
    
}

// MARK: - ViewControllerRepresentable

extension UILandingCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
