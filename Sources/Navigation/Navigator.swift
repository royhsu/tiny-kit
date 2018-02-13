//
//  Navigator.swift
//  TinyKit
//
//  Created by Roy Hsu on 13/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Navigator

import URLNavigator

public final class Navigator {
    
    private final let navigator = URLNavigator.Navigator()
    
    public init() { }
    
}

// MARK: - Navigation

extension Navigator: Navigation {
    
    public final func register(
        _ url: URL,
        with factory: @escaping UIViewControllerFactory
    ) {
        
        let pattern = URLPattern(url.absoluteString)
        
        navigator.register(pattern) { _, values, _ in return factory(url, values) }
        
    }
    
    
    public final func show(
        _ url: URL,
        by type: NavigationType
    ) {

        switch type {
            
        case .push: navigator.push(url)
            
        case .present: navigator.present(url)
            
        case .open: navigator.open(url)
            
        case .root:
            
            fatalError()
            
        }
        
    }

}
