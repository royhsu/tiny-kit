//
//  UIStoreCoordinator.swift
//  TinyApp
//
//  Created by Roy Hsu on 17/03/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UIStoreCoordinator

import TinyKit

public final class UIStoreCoordinator: Coordinator {
    
    /// The navigator.
    private final let collapseBarController: UICollapseBarController
    
    public init() {
        
        self.collapseBarController = UICollapseBarController()
        
    }
    
    // MARK: Coordinator
    
    public final func activate() { }
    
}
