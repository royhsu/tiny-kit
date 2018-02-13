//
//  Navigatoin.swift
//  TinyKit
//
//  Created by Roy Hsu on 13/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Navigation

import UIKit

public typealias UIViewControllerFactory = (_ url: URL, _ info: [String: Any]?) -> UIViewController

public protocol Navigation {
    
    func register(
        _ url: URL,
        with factory: @escaping UIViewControllerFactory
    )
    
    func show(
        _ url: URL,
        by type: NavigationType
    )
    
}

// MARK: - NavigationType

public enum NavigationType {
    
    case push
    
    case present
    
    case open
    
    case root
    
}
