//
//  Navigatoin.swift
//  TinyKit
//
//  Created by Roy Hsu on 13/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - Navigation

import UIKit

public typealias URLHandler = (_ url: URL, _ info: [String: Any]?) -> UIViewController

public protocol Navigation {
    
    func register(
        _ url: URL,
        with handler: @escaping URLHandler
    )
    
    func navigate(
        to url: URL,
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
