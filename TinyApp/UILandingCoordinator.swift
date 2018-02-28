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
    
    private final let navigationController: UINavigationController
    
    private final let landingComponent: UILandingComponent
    
    public init(contentSize: CGSize) {
        
        let landingComponent = UILandingComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
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
            .addButton(
                with: UIPrimaryButtonItem(
                    title: NSLocalizedString(
                        "Sign Up",
                        comment: ""
                    ),
                    titleColor: .white,
                    backgroundColor: .red
                ),
                action: { print("Go sign up!") }
            )
            .addButton(
                with: UIPrimaryButtonItem(
                    title: NSLocalizedString(
                        "Sign In",
                        comment: ""
                    ),
                    titleColor: .white,
                    backgroundColor: .black
                ),
                action: signIn
            )
            .render()
        
    }
    
    fileprivate final func signIn() {
        
        let signInComponent = UISignInComponent().onSubmit { [weak self] email, password in
            
            print(email, password)
            
            self?.navigationController.popViewController(animated: true)
            
        }
        
        let viewController = UIComponentViewController(component: signInComponent)
        
        signInComponent.render()
        
        navigationController.pushViewController(
            viewController,
            animated: true
        )
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UILandingCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
