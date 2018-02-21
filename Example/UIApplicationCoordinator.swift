//
//  UIApplicationCoordinator.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 21/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIApplicationCoordinator

import TinyKit

public final class UIApplicationCoordinator: Coordinator {
    
    public typealias RootCoordinator = Coordinator & ViewControllerRepresentable
    
    private final let window: UIWindow
    
    private final let rootCoordinator: RootCoordinator
    
    public init(rootCoordinator: RootCoordinator) {
        
        self.rootCoordinator = rootCoordinator
        
        let viewController = rootCoordinator.viewController
        
        let window = UIWindow(frame: viewController.view.bounds)
        
        window.rootViewController = viewController
        
        self.window = window
        
    }
    
    public final func activate() {
        
        window.makeKeyAndVisible()
        
        rootCoordinator.activate()
        
    }
    
}
