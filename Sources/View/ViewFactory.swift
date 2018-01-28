//
//  ViewFactory.swift
//  TinyKit
//
//  Created by Roy Hsu on 25/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ViewFactory

public protocol ViewFactory {
    
    associatedtype View: UIView
    
    func makeView() -> View
    
}
