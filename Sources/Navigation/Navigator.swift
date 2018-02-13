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
        with handler: @escaping URLHandler
    ) {
        
        let pattern = URLPattern(url.absoluteString)
        
        navigator.register(pattern) { _, values, _ in
            
            return handler(url, values)
            
        }
        
    }
    
    public final func navigate(
        to url: URL,
        by type: NavigationType
    ) {

        switch type {
            
        case .push: navigator.push(url)
            
        case .present: navigator.present(url)
            
        case .open:
            
            fatalError()
            
        case .root:
            
            fatalError()
            
        }
        
    }

}
