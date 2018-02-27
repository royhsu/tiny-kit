//
//  UILandingCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 27/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UILandingCoordinator

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
                action: { print("clicked!") }
            )
            .render()
        
    }
    
}

// MARK: - ViewControllerRepresentable

extension UILandingCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return navigationController }
    
}
