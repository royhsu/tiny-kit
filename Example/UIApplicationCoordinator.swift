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
    
    private final var authCoordinator: UIAuthCoordinator?

    private final var rootCoordinator: RootCoordinator
    
    public init(contentSize: CGSize) {

        self.window = UIWindow(
            frame: CGRect(
                origin: .zero,
                size: contentSize
            )
        )
        
        let authCoordinator = UIAuthCoordinator(contentSize: contentSize)

        self.authCoordinator = authCoordinator
        
        self.rootCoordinator = authCoordinator
        
    }

    public final func activate() {

        authCoordinator?.onGrant { accessToken in
            
            print(accessToken)
            
        }
        
        window.rootViewController = rootCoordinator.viewController
        
        window.makeKeyAndVisible()

        rootCoordinator.activate()

    }

}
