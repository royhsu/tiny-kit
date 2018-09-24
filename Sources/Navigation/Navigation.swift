//
//  Navigation.swift
//  TinyKit
//
//  Created by Roy Hsu on 2018/9/17.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK - Navigation

public protocol Navigation {
    
    associatedtype Destination
    
    func navigate(to destionation: Destination)
    
}
