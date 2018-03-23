//
//  UIRootCoordinator.swift
//  TinyKitApp
//
//  Created by Roy Hsu on 03/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIRootCoordinator

import TinyKit

import TinyUI
import TinyPost
import TinyStore

public final class UIRootCoordinator: Coordinator {
    
    /// The navigator.
    private final let rootViewController: UIViewController
    
    public init() {
        
        let viewController = UIViewController()
        
        viewController.view.backgroundColor = .white
        
        self.rootViewController = UINavigationController(rootViewController: viewController)
        
    }
    
    // MARK: Coordinator
    
    public final func activate() { }
    
}

// MARK: - ViewRenderable

extension UIRootCoordinator: ViewControllerRepresentable {
    
    public final var viewController: ViewController { return rootViewController }
    
}
