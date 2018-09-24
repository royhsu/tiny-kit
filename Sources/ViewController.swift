//
//  ViewController.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/14.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewController

#if canImport(UIKit)

import UIKit

public typealias ViewController = UIViewController

#else

open class ViewController {
    
    open init() { }
    
}

#endif
