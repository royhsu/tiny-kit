//
//  UIApplicationCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIApplicationCoordinator

import TinyAuth
import TinyKit

public final class UIApplicationCoordinator: Coordinator {

    private final let window: UIWindow

    public typealias RootCoordinator = Coordinator & ViewControllerRepresentable

    private final var rootCoordinator: RootCoordinator

    // TODO: development only.
    private final var rootComponent: Component
    
    public init(contentSize: CGSize) {

        self.window = UIWindow(
            frame: CGRect(
                origin: .zero,
                size: contentSize
            )
        )

        self.rootCoordinator = UILandingCoordinator(contentSize: contentSize)

        self.rootComponent = UISignInComponent(
            contentMode: .size(
                width: contentSize.width,
                height: contentSize.height
            )
        )
        .setSignIn(
            UISignIn(
                email: "hello@world.com",
                password: "helloworld"
            )
        )
        .onSubmit { email, password in
            
            print(email, password)
            
        }
        
    }

    public final func activate() {

//        window.rootViewController = rootCoordinator.viewController

        // TODO: development only.
        window.rootViewController = UIComponentViewController(component: rootComponent)
        
        window.makeKeyAndVisible()

//        rootCoordinator.activate()
        
        // TODO: development only.
        rootComponent.render()

    }

}
